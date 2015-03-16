class TimeRange < ActiveRecord::Base

  scope :mondays,    where(:day => 1)
  scope :tuesdays,   where(:day => 2)
  scope :wednesdays, where(:day => 3)
  scope :thursdays,  where(:day => 4)
  scope :fridays,    where(:day => 5)
  scope :saturdays,  where(:day => 6)
  scope :sundays,    where(:day => 0)

  scope :order_by_day_time, order(:day, :from_hour, :from_minute)

  def to_label
    "#{from_hour}:#{from_minute}"
  end
end
