class Service < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist

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
    @from_fecha_hora_invalid = true
  end

  def validate
    errors.add(:from_fecha_hora, "Es inválida") if @from_fecha_hora_invalid
    errors.add(:to_fecha_hora, "Es inválida") if @to_fecha_hora_invalid
  end

end
