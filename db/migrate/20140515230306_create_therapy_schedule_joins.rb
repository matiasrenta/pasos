class CreateTherapyScheduleJoins < ActiveRecord::Migration
  def self.up
    create_table :therapy_schedule_joins, :id => false do |t|
      t.integer :therapy_id
      t.integer :therapist_schedule_id
      t.timestamps
    end
  end

  def self.down
    drop_table :therapy_schedule_joins
  end
end
