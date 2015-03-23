class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  has_many :time_ranges, :dependent => :nullify

  attr_accessor :apply_timetable_from

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
  validates_uniqueness_of :patient_id, :scope => :therapist_id
  validate :valid_fecha_inicio?, :on => :create
  validate :all_dates_correctly?

  after_touch :handle_services

  private

  def valid_fecha_inicio?
    if fecha_inicio < Date.today
      errors.add(:fecha_inicio, 'No puede ser en el pasado')
      return false
    end
  end

  def all_dates_correctly?
    if fecha_fin && fecha_fin <= fecha_inicio
      errors.add(:fecha_fin, 'Debe ser mayor que la fecha de inicio')
      return false
    elsif timetable_since && timetable_since < fecha_inicio
      errors.add(:timetable_since, 'No puede ser menor a la fecha de inicio')
      return false
    elsif timetable_since && timetable_since <= Date.today
      puts "@@@@@@@@@@@@@@@@ timetable_since=#{timetable_since}; Date.today#{Date.today}"
      errors.add(:timetable_since, 'Debe ser a partir de mañana')
      return false
    end
  end

  def handle_services
    #TODO: si fecha_inicio es muy a futuro no debemos crear services
    #start_date_of_working = fecha_inicio > Date.today ? fecha_inicio : Date.today
    # TODO: deberia ser Date.today porque se necesitara que hoy mismo se creen los servicios para que el paciente asista hoy. El problema es que si ya existe el servicio y ya se precencio, ahi viene el lio
    apply_from_date = fecha_inicio > Date.today ? fecha_inicio : Date.tomorrow
    DaylyServiceCreation.handle_creations_and_destroys_when_change_timetable(self, apply_from_date)

    #end_date_of_working   = start_date_of_working + DaylyServiceCreation.DAYS_FROM_NOW
    #start_end_massive_ranges = TimeRange.start_end_dates_from_massive_adjacent_ranges(self.time_ranges.order_by_day_time)
#
    ##TODO: el campo fecha_inicio no sirve para esta funcionalidad, hay que pregunar al usuario a partir de que fecha se da el cambio de horario
    ## un campo mas que aparezca con el label "A partir de que fecha se aplican estos horarios?" con la fecha Date.today por defecto
    ## destroy los services NOT ESPECIALS a partir de start_date_of_working, que sean de este paciente/terapeuta
    #Service.where("special IS NULL AND patient_id = #{self.patient_id} AND therapist_id = #{self.therapist_id} AND service_type = #{Service.terapia_type[1]}").delete_all
#
    #(end_date_of_working - start_date_of_working).to_i.times do |i|
    #  actual_date = start_date_of_working + i
    #  start_end_massive_ranges.each do |bundle|
    #    if bundle[:day] == actual_date.wday
    #      Service.create(:patient_id => self.patient_id,
    #                     :therapist_id => self.therapist_id,
    #                     :importe => self.patient.costo_terapia_with_tax,
    #                     :service_type => Service.terapia_type[1],
    #                     :from_fecha_hora => ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{actual_date} #{bundle[:start]}", '%d/%m/%Y %H:%M').to_s(:db)),
    #                     :to_fecha_hora => ActiveSupport::TimeZone["Mexico City"].parse(DateTime.strptime("#{actual_date} #{bundle[:end]}", '%d/%m/%Y %H:%M').to_s(:db))
    #      )
    #    end
    #  end
    #end
  end

end
