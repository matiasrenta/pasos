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

  def self.start_end_dates_from_massive_adjacent_ranges(ordered_time_ranges)
    start_end = Array.new
    bundle_adjacents(ordered_time_ranges).each do |bundle_array|
      day = bundle_array.first.day
      start_hour_minute_string = "#{bundle_array.first.from_hour}:#{bundle_array.first.from_minute == 30 ? '30' : '00'}"
      hour   = bundle_array.last.from_minute == 30 ? bundle_array.last.from_hour + 1 : bundle_array.last.from_hour
      minute = bundle_array.last.from_minute == 30 ? '00' : '30'
      end_hour_minute_string   = "#{hour}:#{minute}"
      start_end << {:day => day, :start => start_hour_minute_string, :end => end_hour_minute_string}
    end
    start_end
  end

  def self.bundle_adjacents(ordered_time_ranges)
    bundle_adjacent_arrays = Array.new
    adjacent_array = Array.new
    last_tr = nil
    ordered_time_ranges.each_with_index do |tr, i|
      if i == 0
        adjacent_array << tr
      else
        # si son adyacentes entonces: (son del mismo dia) Y ( (son la misma hora) O (es de la hora siguiente y el last_tr.from_minute es 30)
        if (tr.day == last_tr.day) && ( (tr.from_hour == last_tr.from_hour) || (last_tr.from_hour + 1 == tr.from_hour && last_tr.from_minute == 30) )
          adjacent_array << tr
        else
          bundle_adjacent_arrays << adjacent_array
          adjacent_array = Array.new
          adjacent_array << tr
        end
      end
      last_tr = tr
    end
    bundle_adjacent_arrays << adjacent_array
    bundle_adjacent_arrays
  end

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
