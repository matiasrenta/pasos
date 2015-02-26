class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :nombre
      t.string :nombre_padre
      t.string :nombre_madre
      t.string :tel_casa
      t.string :cel_padre
      t.string :cel_madre
      t.string :email
      t.date :fecha_ingreso
      t.boolean :recibo_donativo
      t.boolean :factura
      t.string :nombre_empresa
      t.string :direccion
      t.string :colonia
      t.string :delegacion
      t.string :cp
      t.string :ciudad
      t.string :email_empresa
      t.decimal :costo_terapia, :precision => 10, :scale => 2
      t.decimal :saldo, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
