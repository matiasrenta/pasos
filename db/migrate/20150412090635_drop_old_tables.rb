class DropOldTables < ActiveRecord::Migration
  def self.up
    drop_table :assessments
    drop_table :presences
    drop_table :special_dates
    drop_table :therapies
    drop_table :therapist_schedules
    drop_table :therapy_schedule_joins
  end

  def self.down
  end
end
