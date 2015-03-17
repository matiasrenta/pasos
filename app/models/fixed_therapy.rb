class FixedTherapy < ActiveRecord::Base
  belongs_to :patient
  belongs_to :therapist
  has_many :time_ranges, :dependent => :nullify

  validates_presence_of :patient_id, :therapist_id, :fecha_inicio
  validates_uniqueness_of :patient_id, :scope => :therapist_id
  validate :all_dates_correctly?

  after_touch :handle_services

  private

  def all_dates_correctly?
    if fecha_inicio < Date.today
      errors.add(:fecha_inicio, 'No puede ser en el pasado')
      return false
    elsif fecha_fin && fecha_fin <= fecha_inicio
      errors.add(:fecha_fin, 'Debe ser mayor que la fecha de inicio')
      return false
    end
  end

  def handle_services
    #TODO: si fecha_inicio es muy a futuro no debemos crear services
    start_date_of_working = fecha_inicio > Date.today ? fecha_inicio : Date.today
    end_date_of_working   = start_date_of_working + 1.month
    start_end_massive_ranges = TimeRange.start_end_dates_from_massive_adjacent_ranges(self.time_ranges.order_by_day_time)

    #TODO: el campo fecha_inicio no sirve para esta funcionalidad, hay que pregunar al usuario a partir de que fecha se da el cambio de horario
    # un campo mas que aparezca con el label "A partir de que fecha se aplican estos horarios?" con la fecha Date.today por defecto
    puts "######################################################################################## debug 2"

    # primero hay que destroy_all los services a partir de start_date_of_working si tienen dia hora inicio igual a {bundle[:start]


    (end_date_of_working - start_date_of_working).to_i.times do |i|
      actual_date = start_date_of_working + i
      start_end_massive_ranges.each do |bundle|

        puts "#{bundle[:day]} // #{actual_date.wday}"
        if bundle[:day] == actual_date.wday
          puts "creao service con from_fecha_hora: #{actual_date} #{bundle[:start]} y to_fecha_hora: #{actual_date} #{bundle[:end]}"
        end
      end
    end

    puts "######################################################################################## debug 3"
  end

end
