class AddMotivoToCancellations < ActiveRecord::Migration
  def self.up
    add_column :cancellations, :motivo, :text
  end

  def self.down
    remove_column :cancellations, :motivo
  end
end
