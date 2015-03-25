class Nomina < ActiveRecord::Base
  belongs_to :therapist
  has_many :services, :dependent => :nullify

  attr_accessor :massive_date

  validates_presence_of :therapist_id, :fecha, :concepto

  before_create :set_services_and_total

  def self.create_for_all_therapists(to_date)
    create_for_therapists(to_date, Therapist.actives)
  end

  def self.create_for_therapists(to_date, therapists)
    therapists.each do |therapist|
      nomina = Nomina.new(:therapist_id => therapist.id, :fecha => to_date, :concepto => 'Pago servicios')
      puts "antes de save nomina.services.count = #{nomina.services.count}"
      nomina.save!
      puts "nomina.services.count = #{nomina.services.count}"
    end
  end

  def set_services_and_total
    puts "###############################################"
    puts "###############################################"
    puts "self.therapist.nombre: #{self.therapist.nombre}"
    last_nominado = Service.by_therapist(self.therapist.id).nominados.order('from_fecha_hora DESC').first

    from_date = last_nominado ? last_nominado.from_fecha_hora : 10.years.ago
    puts "from_date: #{from_date}"
    # los servicios seran hasta el dia de anterior a self.fecha, ya que self.fecha será menor al datetime del servicio por unas horas

    puts "@@@@@@@@@@@@@@@"
    puts Service.asistidos.no_nominados.by_therapist(self.therapist.id).from_date(from_date).to_date(self.fecha).to_sql
    puts "@@@@@@@@@@@@@@@"
    services_a_nominar = Service.asistidos.no_nominados.by_therapist(self.therapist.id).from_date(from_date).to_date(self.fecha)
    puts "services_a_nominar.size: #{services_a_nominar.size}"
    self.services = services_a_nominar
    puts "services_a_nominar.sum(:importe): #{services_a_nominar.sum(:importe)}"
    self.total = services_a_nominar.sum(:importe)
    puts "self.total: #{self.total}"
  end

end
