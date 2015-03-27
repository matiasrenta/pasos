class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  has_many :time_ranges, :dependent => :nullify

  attr_accessor :apply_timetable_from

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
  validates_uniqueness_of :patient_id, :scope => :therapist_id
  validate :valid_fecha_inicio?, :on => :create
  validate :all_dates_correctly?

  #after_touch :handle_services

  def handle_services
    #apply_from_date = fecha_inicio > Date.today ? fecha_inicio : Date.tomorrow
    DaylyServiceCreation.handle_creations_and_destroys_when_change_timetable(self, self.timetable_since)
  end

  private

  def valid_fecha_inicio?
    if fecha_inicio < Date.today
      errors.add(:fecha_inicio, 'No puede ser en el pasado')
      return false
    end
  end

  def all_dates_correctly?
    if fecha_fin && fecha_fin <= fecha_inicio
      errors.add(:fecha_fin, 'Debe ser mayor que la fecha de inicio')
      return false
    elsif timetable_since && timetable_since < fecha_inicio
      errors.add(:timetable_since, 'No puede ser menor a la fecha de inicio')
      return false
    elsif timetable_since && timetable_since <= Date.today
      errors.add(:timetable_since, 'Debe ser a partir de mañana')
      return false
    end
  end



end
