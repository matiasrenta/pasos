class AddDiagnosticoToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :diagnostico, :text
  end

  def self.down
    remove_column :patients, :diagnostico
  end
end
