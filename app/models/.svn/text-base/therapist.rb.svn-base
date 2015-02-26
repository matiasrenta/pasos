class Therapist < ActiveRecord::Base
  belongs_to :state
  has_many :therapist_schedules, :dependent => :destroy, :order => 'therapist_schedules.dia, therapist_schedules.hora'
  has_many :therapies

  validates_presence_of :nombre, :state_id

  accepts_nested_attributes_for :therapist_schedules, :allow_destroy => true#, :reject_if => lambda { |a| a[:name].blank? && a[:email].blank? && a[:phones].blank? && a[:description].blank?}

  def dues_special_dates
    list = Array.new
    SpecialDate.joins(:therapy).where("therapies.therapist_id = ? AND special_dates.fecha_hora >= ?", self.id, Time.zone.now.to_date.yesterday).each do |special_date|
      list << special_date if special_date.fecha_hora.to_date >= Time.zone.now.to_date
    end
    return list
  end

end
