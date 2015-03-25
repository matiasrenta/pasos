class Nomina < ActiveRecord::Base
  belongs_to :therapist
  has_many :services, :dependent => :nullify

  validates_presence_of :therapist_id, :fecha, :concepto

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
    last_nominado = Service.by_therapist(self.therapist.id).last_nominado.first
    # los servicios seran hasta el dia de ayer, ya que la fecha será menor al datetime del servicio
    self.services = Service.asistidos.no_nominados.by_therapist(self.therapist.id).from_date(last_nominado.from_fecha_hora).to_date(self.fecha)
    self.total = self.services.sum(:importe)
  end

end
