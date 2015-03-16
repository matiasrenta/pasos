class AddWorkingTimeToTimeRanges < ActiveRecord::Migration
  def self.up
    add_column :time_ranges, :working_time, :boolean
    add_column :time_ranges, :taken, :boolean
    remove_column :time_ranges, :available
  end

  def self.down
    remove_column :time_ranges, :taken
    remove_column :time_ranges, :working_time
  end
end
