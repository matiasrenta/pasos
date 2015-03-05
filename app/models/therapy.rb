class Therapy < ActiveRecord::Base



  
  belongs_to :therapist
  belongs_to :patient
  belongs_to :state
  has_many :presences
  has_many :special_dates
  has_and_belongs_to_many :therapist_schedules, :join_table => "therapy_schedule_joins", :order => 'therapist_schedules.dia, therapist_schedules.hora'

  validates_presence_of :therapist_id, :state_id #todo: hay que poner fecha_inicio en el formulario
  validates_uniqueness_of :therapist_id, :scope => :patient_id

  accepts_nested_attributes_for :special_dates, :allow_destroy => true

  scope :sessions_in_date, lambda {|fecha| includes(:therapist_schedules, :special_dates).
      where("therapist_schedules.dia = #{fecha.wday}
             OR (special_dates.cancellation = ? AND special_dates.fecha_hora >= ? AND special_dates.fecha_hora < ?)",
              false,
              ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{fecha} 00:00:00", '%d/%m/%Y %H:%M:%S').to_s(:db)),
              ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{fecha.tomorrow} 00:00:00", '%d/%m/%Y %H:%M:%S').to_s(:db))).
      order("therapist_schedules.hora, special_dates.fecha_hora")}

  scope :actives, where("therapies.state_id = ?", State.active.id)
  scope :order_by_therapist, joins(:therapist).order("therapists.nombre")

  def self.cancelled?(therapy, schedule, time = Time.zone.now)
    count = SpecialDate.where("therapy_id = #{therapy.id} AND cancellation = ? AND fecha_hora = ?", true, ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{time.to_date} #{schedule.hora}:00:00", '%d/%m/%Y %H:%M:%S').to_s(:db))).count
    return count > 0
  end

  def self.presenced?(therapy, schedule_or_special_date, time = Time.zone.now)
    if schedule_or_special_date.instance_of?(TherapistSchedule)
      hora = schedule_or_special_date.hora
    elsif schedule_or_special_date.instance_of?(SpecialDate)
      hora = schedule_or_special_date.fecha_hora.strftime('%H')
    else
      raise(ArgumentError, "No se puede procesar #{schedule_or_special_date.class}. debe ser TherapistSchedule o SpecialDate")
    end
    return Presence.exists_for_therapy_hour_in_date?(therapy, hora, time)
  end


  def self.schedule_or_special_in_date?(schedule_or_special_date, time = Time.zone.now )
    if schedule_or_special_date.instance_of?(TherapistSchedule)
      return schedule_or_special_date.dia == time.wday
    elsif schedule_or_special_date.instance_of?(SpecialDate)
      return schedule_or_special_date.fecha_hora.to_date == time.to_date && schedule_or_special_date.extra_session?
    else
      raise(ArgumentError, "No se puede procesar #{schedule_or_special_date.class}. debe ser TherapistSchedule o SpecialDate")
    end
  end

  def self.presenciable_session?(therapy, schedule_or_special_date, time = Time.zone.now )
    if schedule_or_special_date.instance_of?(TherapistSchedule)
      return schedule_or_special_in_date?(schedule_or_special_date, time) && !cancelled?(therapy, schedule_or_special_date, time) && !presenced?(therapy, schedule_or_special_date, time)

    elsif schedule_or_special_date.instance_of?(SpecialDate)
      return schedule_or_special_in_date?(schedule_or_special_date, time) && schedule_or_special_date.extra_session? && !presenced?(therapy, schedule_or_special_date, time)

    else
      raise(ArgumentError, "No se puede procesar #{schedule_or_special_date.class}. debe ser TherapistSchedule o SpecialDate")
    end
  end

  #retorna true si hay alguna sesion presenciable para el time, ya sea un schedule o especial date que no este ya precenciada ni cancelada
  def self.with_presenciable_in_date?(therapy, time = Time.zone.now)
    therapy.therapist_schedules.each do |schedule|
      if schedule_or_special_in_date?(schedule, time) && !cancelled?(therapy, schedule, time) && !presenced?(therapy, schedule, time)
        return true
      end
    end
    therapy.special_dates.each do |special_date|
      if schedule_or_special_in_date?(special_date, time) && !presenced?(therapy, special_date, time) ## no necesito preguntar por cancelled porque los especial dates deberian ser eliminados si no se van a presenciar
        return true
      end
    end

    return false
  end

  def name
    "#{therapist.nombre} - Paciente: #{patient.nombre}"
  end

end
