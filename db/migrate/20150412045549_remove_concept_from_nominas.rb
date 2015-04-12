class RemoveConceptFromNominas < ActiveRecord::Migration
  def self.up
    remove_column :nominas, :concepto
  end

  def self.down
  end
end
