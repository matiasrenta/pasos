class SpecialDate < ActiveRecord::Base
  belongs_to :therapy

  validates_presence_of :therapy_id, :fecha_hora

  def fecha_hora_string
    fecha_hora.to_s
  end

  def fecha_hora_string=(fecha_hora_str)
    self.fecha_hora = ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime(fecha_hora_str, '%d/%m/%Y %H:%M').to_s(:db))
  rescue ArgumentError
    @fecha_hora_invalid = true
  end

  def validate
    errors.add(:fecha_hora, "Es inválida") if @fecha_hora_invalid
  end



  def name
    if self.cancellation
      "#{I18n.l(self.fecha_hora, :format => :short_day)} Cancel."
    else
      "#{I18n.l(self.fecha_hora, :format => :short_day)}"
    end
  end

  def extra_session?
    !self.cancellation
  end

  def cancellation?
    self.cancellation
  end

end
