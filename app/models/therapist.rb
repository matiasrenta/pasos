class Therapist < ActiveRecord::Base
  belongs_to :state
  has_many :therapist_schedules, :dependent => :destroy, :order => 'therapist_schedules.dia, therapist_schedules.hora'
  has_many :therapies

  has_many :services
  has_many :time_ranges, :dependent => :delete_all
  has_many :fixed_therapies
  has_many :cancellations

  attr_accessor :apply_timetable_from

  validates_presence_of :nombre, :state_id

  accepts_nested_attributes_for :therapist_schedules, :allow_destroy => true#, :reject_if => lambda { |a| a[:name].blank? && a[:email].blank? && a[:phones].blank? && a[:description].blank?}

  after_create :create_time_range

  def dues_special_dates
    list = Array.new
    SpecialDate.joins(:therapy).where("therapies.therapist_id = ? AND special_dates.fecha_hora >= ?", self.id, Time.zone.now.to_date.yesterday).each do |special_date|
      list << special_date if special_date.fecha_hora.to_date >= Time.zone.now.to_date
    end
    return list
  end


  private

  def create_time_range
    7.times do |t1|
      15.times do |t2|
        2.times do |t3|
          fh = t2 + 7 # a partir de las 7 de la maniana
          fm = t3 == 0 ? 0 : 30 # va de media hora en media hora
          TimeRange.create(:therapist_id => self.id, :day => t1, :from_hour => fh, :from_minute => fm)
        end
      end
    end
  end

end
