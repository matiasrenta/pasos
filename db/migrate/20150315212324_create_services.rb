class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :patient_id
      t.integer :therapist_id
      t.datetime :from_fecha_hora
      t.datetime :to_fecha_hora
      t.decimal :importe, :precision => 10, :scale => 2
      t.text :datos_escuela
      t.string :nombre_profesor
      t.string :grado_escolar
      t.boolean :asistido
      t.boolean :cancelado
      t.text :motivo_cancelacion
      t.integer :service_type

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
