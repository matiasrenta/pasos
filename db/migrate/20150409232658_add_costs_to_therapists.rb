class AddCostsToTherapists < ActiveRecord::Migration
  def self.up
    add_column :therapists, :therapy_cost, :float
    add_column :therapists, :valoracion_cost, :float
    add_column :therapists, :visita_cost, :float
  end

  def self.down
    remove_column :therapists, :visita_cost
    remove_column :therapists, :valoracion_cost
    remove_column :therapists, :therapy_cost
  end
end
