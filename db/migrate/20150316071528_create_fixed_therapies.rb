class CreateFixedTherapies < ActiveRecord::Migration
  def self.up
    create_table :fixed_therapies do |t|
      t.integer :patient_id
      t.integer :therapist_id
      t.date :fecha_inicio
      t.date :fecha_fin

      t.timestamps
    end
  end

  def self.down
    drop_table :fixed_therapies
  end
end
