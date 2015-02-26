class Presence < ActiveRecord::Base
  belongs_to :therapy

  validates_presence_of :therapy, :fecha_hora, :importe

  before_validation do
    if !importe && self.therapy
      patient = self.therapy.patient
      self.importe = patient.factura ? patient.costo_terapia_with_tax : patient.costo_terapia
    end
  end
  after_create :calculate_patient_saldo
  after_destroy :calculate_patient_saldo_destroy

  def self.exists_for_therapy_hour_in_date?(therapy, hour, time)
    count = where("therapy_id = #{therapy.id} AND fecha_hora = ?", ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{time.to_date} #{hour}:00:00", '%d/%m/%Y %H:%M:%S').to_s(:db))).count
    return count > 0
  end

  #tuve que hacer este lio porque en la base de datos esta en UTC, y no puedo comparar fechas con SQL, por eso le pongo: Time.zone.now.to_date.yesterday, Time.zone.now.to_date + 2.days, y luego de esos registros filtro con la fecha ya convertida por rails. Una mierda, guardar en UTC los datetime no es bueno para una app que solo va a estar en un timezone, no puedes hacer sqls que comparen fechas
  def self.for_today_list
    list = Array.new
    where("fecha_hora >= ? AND fecha_hora <= ?", Time.zone.now.to_date.yesterday, Time.zone.now.to_date + 2.days).order("created_at DESC").each do |presence|
      list << presence if presence.fecha_hora.to_date >= Time.zone.now.to_date && presence.fecha_hora.to_date < Time.zone.now.to_date.tomorrow
    end
    return list
  end


  private

  def calculate_patient_saldo
    if self.therapy.patient.saldo
      self.therapy.patient.saldo = self.therapy.patient.saldo - self.importe
    else
      self.therapy.patient.saldo = 0 - self.importe
    end
    self.therapy.patient.save!
  end

  def calculate_patient_saldo_destroy
    self.therapy.patient.saldo = self.therapy.patient.saldo + self.importe
    self.therapy.patient.save!
  end

end
