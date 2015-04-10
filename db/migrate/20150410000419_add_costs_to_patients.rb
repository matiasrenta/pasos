class AddCostsToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :tarifa_especial, :boolean
    add_column :patients, :forced_therapy_cost, :float
    add_column :patients, :forced_valoracion_cost, :float
    add_column :patients, :forced_visita_cost, :float
  end

  def self.down
    remove_column :patients, :forced_visita_cost
    remove_column :patients, :forced_valoracion_cost
    remove_column :patients, :forced_therapy_cost
    remove_column :patients, :tarifa_especial
  end
end
