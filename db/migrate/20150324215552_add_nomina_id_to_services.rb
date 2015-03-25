class AddNominaIdToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :nomina_id, :integer
  end

  def self.down
    remove_column :services, :nomina_id
  end
end
