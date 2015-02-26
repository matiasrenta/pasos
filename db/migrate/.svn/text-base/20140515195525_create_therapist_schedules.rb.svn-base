class CreateTherapistSchedules < ActiveRecord::Migration
  def self.up
    create_table :therapist_schedules do |t|
      t.integer :therapist_id
      t.integer :dia
      t.integer :hora
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :therapist_schedules
  end
end
