class TimeRange < ActiveRecord::Base
  belongs_to :therapist
  belongs_to :patient
  belongs_to :fixed_therapy

  validates_presence_of :therapist_id, :day, :from_hour, :from_minute
  validate :taken_in_worging_time?
  validate :not_revert_working_time_if_taken

  before_save do
    self.patient_id = nil if !taken
    self.fixed_therapy_id = nil if !taken
  end

  scope :mondays,    where(:day => 1)
  scope :tuesdays,   where(:day => 2)
  scope :wednesdays, where(:day => 3)
  scope :thursdays,  where(:day => 4)
  scope :fridays,    where(:day => 5)
  scope :saturdays,  where(:day => 6)
  scope :sundays,    where(:day => 0)

  scope :order_by_day_time, order(:day, :from_hour, :from_minute)

  def to_label
    "#{from_hour}:#{from_minute}"
  end

  private

  def taken_in_worging_time?
    if !working_time && taken
      errors.add(:taken, "Horario no disponible")
    end
  end

  def not_revert_working_time_if_taken
    if taken && !working_time && working_time_was
      errors.add(:working_time, "Horario asignado a #{self.patient.try(:nombre)}, reasigne primero el horario para este paciente")
    end
  end

end
