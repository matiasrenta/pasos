class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist

  before_destroy :clean_time_ranges #lo pongo antes del has_many porque sino primero quedan nullify y entonces no los puedo updatear
  has_many :time_ranges, :dependent => :nullify

  attr_accessor :apply_timetable_from

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
  validates_uniqueness_of :patient_id, :scope => :therapist_id
  validate :valid_fecha_inicio?, :on => :create
  validate :all_dates_correctly?



  # running significa que la fecha de fin no ha llegado por lo tanto esta vivo este fixed_therapy
  scope :running, lambda{where("fecha_inicio <= ? AND (fecha_fin IS NULL OR fecha_fin >= ?)", Date.today, Date.today)}
  scope :finalized, lambda{where("fecha_fin IS NOT NULL AND fecha_fin < ?", Date.today)}

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

  # cuando se elimina un fixed_therapy no basta con decir que los time_rages queden :nullify
  # hay que nullify tambien el paciente y ponerlo como NO taken (no se puede hacer en un callback en TimeRange porque :nullify no ejecuta los callbacks)
  def clean_time_ranges
    time_ranges.update_all(:patient_id => nil, :taken => false)
  end


end
