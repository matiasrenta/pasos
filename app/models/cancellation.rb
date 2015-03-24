class Cancellation < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  belongs_to :user

  before_destroy :revert_services_cancellation #lo pongo antes del has many para que services tenga algo en el before_destroy
  has_many :services, :dependent => :nullify

  validates_presence_of :user_id, :motivo, :cancel_from_fecha
  validate :all_dates_correctly?

  before_create :set_services_to_cancel
  after_create :cancel_services


  private

  def set_services_to_cancel
    q = "Service"
    q = q.concat(".cancelables")
    q = q.concat(".by_patient(patient_id)") if patient_id
    q = q.concat(".by_therapist(therapist_id)") if therapist_id
    q = q.concat(".from_date(cancel_from_fecha)") if cancel_from_fecha
    q = q.concat(".to_date(cancel_to_fecha)") if cancel_to_fecha
    q = q.concat(".by_service_type(service_type)") if service_type

    self.services = eval(q)
  end

  def cancel_services
    self.services.update_all(:cancelado => true, :motivo_cancelacion => motivo)
  end

  def revert_services_cancellation
    # SOLO SE REVIERTEN LOS SERVICIOS CANCELADOS A PARTIR DE HOY QUE NO ESTEN ASISTIDOS, los anteriores quedan cancelados (con cancellation_id = nil)
    services.from_date(Date.today).no_asistidos.update_all(:cancelado => false, :motivo_cancelacion => nil)
  end

  def all_dates_correctly?
    if cancel_from_fecha < Date.today
      errors.add(:cancel_from_fecha, "debe ser a partir de hoy")
    elsif cancel_to_fecha && cancel_to_fecha < cancel_from_fecha
      errors.add(:cancel_to_fecha, "no puede ser menor a la fecha desde")
    end
  end



end
