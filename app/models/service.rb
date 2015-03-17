class Service < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist

  validates_presence_of :patient_id, :therapist_id, :from_fecha_hora, :to_fecha_hora, :from_fecha_hora_string, :to_fecha_hora_string, :importe, :service_type
  validates_presence_of :datos_escuela, :nombre_profesor, :grado_escolar, :if => :visita_escolar?
  validates_presence_of :motivo_cancelacion, :if => :cancelado
  validate :asistido_in_past?
  #TODO: asegurar que un paciente no tenga dos servicios intersectados en un mismo dia
  #validate :uniq_service_at_time

  #def self.calculate_to_fecha_hora(from_f_h)
  #  ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime(from_f_h, '%d/%m/%Y %H:%M').to_s(:db)) + 1.hour
  #end


  def visita_escolar?
    self.service_type == 3
  end

  def service_type_name
    case self.service_type
      when 1: 'Terapia'
      when 2: 'Valoración'
      when 3: 'Visita escolar'
    end
  end

  def from_fecha_hora_string
    from_fecha_hora.to_s
  end

  def to_fecha_hora_string
    from_fecha_hora.to_s
  end

  def from_fecha_hora_string=(fecha_hora_str)
    self.from_fecha_hora = ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime(fecha_hora_str, '%d/%m/%Y %H:%M').to_s(:db))
  rescue ArgumentError
    @from_fecha_hora_invalid = true
  end

  def to_fecha_hora_string=(fecha_hora_str)
    self.to_fecha_hora = ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime(fecha_hora_str, '%d/%m/%Y %H:%M').to_s(:db))
  rescue ArgumentError
    @to_fecha_hora_invalid = true
  end

  def validate
    errors.add(:from_fecha_hora, "Es inválida") if @from_fecha_hora_invalid
    errors.add(:to_fecha_hora, "Es inválida") if @to_fecha_hora_invalid
  end

  def asistido_in_past?
    if asistido && from_fecha_hora.to_date > Date.today
      errors.add(:asistido, 'La fecha del servicio no ha llegado')
    end
  end

  def uniq_service_at_time

  end


end
