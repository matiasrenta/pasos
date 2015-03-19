class AddTimetableSinceToFixedTherapies < ActiveRecord::Migration
  def self.up
    add_column :fixed_therapies, :timetable_since, :date
  end

  def self.down
    remove_column :fixed_therapies, :timetable_since
  end
end
