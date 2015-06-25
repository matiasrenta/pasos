class Therapist < ActiveRecord::Base
  belongs_to :state
  has_many :services
  has_many :time_ranges, :dependent => :delete_all
  has_many :fixed_therapies
  has_many :cancellations

  attr_accessor :apply_timetable_from

  validates_presence_of :nombre, :state_id, :therapy_cost, :valoracion_cost, :visita_cost

  after_create :create_time_range

  scope :ordered, order(:nombre)

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
