class Nomina < ActiveRecord::Base
  belongs_to :therapist
  has_many :services, :dependent => :nullify

  validates_presence_of :therapist_id, :fecha
  validate :fecha_in_past?

  before_create :set_services_and_total
  before_create do
    max_nro_nomina = Nomina.maximum(:nro_nomina)
    self.nro_nomina = max_nro_nomina ? max_nro_nomina + 1 : Settings.nomina_start_folio
  end


  def self.create_for_all_therapists(to_date, controller)
    create_for_therapists(to_date, Therapist.actives, controller)
  end

  def self.create_for_therapists(to_date, therapists, controller)
    therapists.each do |therapist|
      nomina = Nomina.new(:therapist_id => therapist.id, :fecha => to_date)
      if nomina.save
        #nomina.reload
        nomina.generate_pdf_text(controller)
        nomina.save
      end
    end
  end

  def set_services_and_total
    last_nominado = Service.by_therapist(self.therapist.id).nominados.order('from_fecha_hora DESC').first
    from_date = last_nominado ? last_nominado.from_fecha_hora : 10.years.ago
    # los servicios seran hasta el dia de anterior a self.fecha, ya que self.fecha será menor al datetime del servicio por unas horas
    self.total = 0
    Service.asistidos.no_nominados.by_therapist(self.therapist.id).from_date(from_date).to_date(self.fecha).each do |service|
      self.services << service
      self.total = self.total + service.therapist_cost.to_f
    end
  end

  def generate_pdf_text(controller)
    self.pdf_text = controller.render_to_string(:partial => "html_origin", :layout => false)
  end

  def detailed_concept
    if services.count > 20
      detailed_concept_for_lot_of_services
    else
      detailed_concept_for_little_services
    end
  end

  private

  def detailed_concept_for_little_services
    rows = Array.new
    services.order_by_date.each do |service|
      html_text = "#{service.from_fecha_hora}, #{service.service_type_name}, paciente: #{service.patient.nombre}"
      rows << {:text => html_text, :importe => service.therapist_cost}
    end
    rows
  end

  def detailed_concept_for_lot_of_services
    therapies = services.therapies.order_by_date
    valoraciones = services.valoraciones.order_by_date
    visitas_escolares = services.visitas_escolares.order_by_date
    rows = Array.new
    rows << {:text => "#{therapies.count} Terapias: #{therapies.map(&:from_fecha_hora).join(', ')}", :importe => therapies.sum(:therapist_cost)}
    rows << {:text => "#{valoraciones.count} Valoraciones: #{valoraciones.map(&:from_fecha_hora).join(', ')}", :importe => valoraciones.sum(:therapist_cost)}
    rows << {:text => "#{visitas_escolares.count} Visitas_escolares: #{visitas_escolares.map(&:from_fecha_hora).join(', ')}", :importe => visitas_escolares.sum(:therapist_cost)}
  end

  def fecha_in_past?
    if fecha >= Date.today
      errors.add(:fecha, 'debe ser a lo sumo la fecha de ayer')
    end
  end

end
