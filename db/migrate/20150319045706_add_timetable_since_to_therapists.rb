class AddTimetableSinceToTherapists < ActiveRecord::Migration
  def self.up
    add_column :therapists, :timetable_since, :date
  end

  def self.down
    remove_column :therapists, :timetable_since
  end
end
