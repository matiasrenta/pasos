class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  has_many :time_ranges, :dependent => :nullify

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
  validates_uniqueness_of :patient_id, :scope => :therapist_id
  validate :all_dates_correctly?

  private

  def all_dates_correctly?
    if fecha_inicio < Date.today
      errors.add(:fecha_inicio, 'No puede ser en el pasado')
      return false
    elsif fecha_fin && fecha_fin <= fecha_inicio
      errors.add(:fecha_fin, 'Debe ser mayor que la fecha de inicio')
      return false
    end
  end

end
