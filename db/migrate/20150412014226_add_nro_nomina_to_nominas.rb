class AddNroNominaToNominas < ActiveRecord::Migration
  def self.up
    add_column :nominas, :nro_nomina, :integer
  end

  def self.down
    remove_column :nominas, :nro_nomina
  end
end
