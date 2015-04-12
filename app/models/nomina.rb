class Nomina < ActiveRecord::Base
  belongs_to :therapist
  has_many :services, :dependent => :nullify

  validates_presence_of :therapist_id, :fecha, :concepto
  validate :fecha_in_past?

  before_create :set_services_and_total

  def self.create_for_all_therapists(to_date)
    create_for_therapists(to_date, Therapist.actives)
  end

  def self.create_for_therapists(to_date, therapists)
    therapists.each do |therapist|
      nomina = Nomina.new(:therapist_id => therapist.id, :fecha => to_date, :concepto => 'Pago servicios')
      nomina.save
    end
  end

  def set_services_and_total
    last_nominado = Service.by_therapist(self.therapist.id).nominados.order('from_fecha_hora DESC').first
    from_date = last_nominado ? last_nominado.from_fecha_hora : 10.years.ago
    # los servicios seran hasta el dia de anterior a self.fecha, ya que self.fecha será menor al datetime del servicio por unas horas
    Service.asistidos.no_nominados.by_therapist(self.therapist.id).from_date(from_date).to_date(self.fecha).each do |service|
      self.services << service
      self.total = self.total.to_f + service.therapist_cost.to_f
    end
  end

  private

  def fecha_in_past?
    if fecha >= Date.today
      errors.add(:fecha, 'debe ser a lo sumo la fecha de ayer')
    end
  end

end
