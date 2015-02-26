class AddAltaToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :fecha_alta, :date
    add_column :patients, :motivo_alta, :text
  end

  def self.down
    remove_column :patients, :motivo_alta
    remove_column :patients, :fecha_alta
  end
end
