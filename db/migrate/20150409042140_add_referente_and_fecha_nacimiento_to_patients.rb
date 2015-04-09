class AddReferenteAndFechaNacimientoToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :referente, :string
    add_column :patients, :fecha_nacimiento, :date
  end

  def self.down
    remove_column :patients, :fecha_nacimiento
    remove_column :patients, :referente
  end
end
