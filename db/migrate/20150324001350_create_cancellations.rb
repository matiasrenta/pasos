class CreateCancellations < ActiveRecord::Migration
  def self.up
    create_table :cancellations do |t|
      t.integer :patient_id
      t.integer :therapist_id
      t.date :cancel_from_fecha
      t.date :cancel_to_fecha
      t.datetime :service_from_fecha_hora
      t.integer :service_type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cancellations
  end
end
