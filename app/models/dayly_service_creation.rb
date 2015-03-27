class DaylyServiceCreation < ActiveRecord::Base

  DAYS_FROM_NOW = 15 # dias desde la fecha de hoy hasta donde se van a crear los servicios.

  def self.handle_creations
    record = first
    today = Date.today
    if record.last_creation < today
      if (today + DAYS_FROM_NOW) > record.until_date
        create_services(FixedTherapy.all, record.until_date + 1, today + DAYS_FROM_NOW)
        record.last_creation = today
        record.until_date = today + DAYS_FROM_NOW
        record.save!
      end
    end
  end

  def self.handle_creations_and_destroys_when_change_timetable(fixed_therapy, apply_from_date)
    # se hace a partir de maniana para evitar manejar el problema de eliminar servicios ya presenciados
    return false if apply_from_date < Date.tomorrow
    Service.where("special IS NULL AND from_fecha_hora >= ? AND patient_id = ? AND therapist_id = ? AND service_type = ?", apply_from_date, fixed_therapy.patient_id, fixed_therapy.therapist_id, Service.terapia_type[1]).delete_all
    stop_date = first.until_date
    create_services([fixed_therapy], apply_from_date, stop_date) # mandamos stop_date para que no se creen servicio posterior al first.until_date, asi maniana no hay problema en la creacion automatica
  end

  private

  def self.create_services(fixed_therapies, from_date, stop_date)
    fixed_therapies.each do |fixed_therapy|
      start_end_massive_ranges = TimeRange.start_end_dates_from_massive_adjacent_ranges(fixed_therapy.time_ranges.order_by_day_time)
      actual_date = from_date < Date.tomorrow ? Date.tomorrow : from_date
      puts "actual_date=#{actual_date} - stop_date=#{stop_date}"
      while actual_date <= stop_date do
        start_end_massive_ranges.each {|bundle| create_service(fixed_therapy, actual_date, bundle) if bundle[:day] == actual_date.wday}
        actual_date = actual_date + 1
      end
    end
  end

  def self.create_service(fixed_therapy, actual_date, bundle)
    Service.create(:patient_id => fixed_therapy.patient_id,
                   :therapist_id => fixed_therapy.therapist_id,
                   :importe => fixed_therapy.patient.costo_terapia_with_tax,
                   :service_type => Service.terapia_type[1],
                   :from_fecha_hora => ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{actual_date} #{bundle[:start]}", '%d/%m/%Y %H:%M').to_s(:db)),
                   :to_fecha_hora => ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{actual_date} #{bundle[:end]}", '%d/%m/%Y %H:%M').to_s(:db))
    )
  end

end
