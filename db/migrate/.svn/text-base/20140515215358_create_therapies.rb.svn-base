class CreateTherapies < ActiveRecord::Migration
  def self.up
    create_table :therapies do |t|
      t.integer :patient_id
      t.integer :therapist_id
      t.date :fecha_inicio
      t.integer :sesiones_semanales
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :therapies
  end
end
