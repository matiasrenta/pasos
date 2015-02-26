class AddRoleIdAndStateIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role_id, :integer
    add_column :users, :state_id, :integer
  end

  def self.down
    remove_column :users, :role_id
    remove_column :users, :state_id
  end
end
