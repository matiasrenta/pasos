class CreateTimeRanges < ActiveRecord::Migration
  def self.up
    create_table :time_ranges do |t|
      t.integer :therapist_id
      t.integer :day
      t.integer :from_hour
      t.integer :from_minute
      t.boolean :available

      t.timestamps
    end
  end

  def self.down
    drop_table :time_ranges
  end
end
