class AddHumanResourceFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name,             :string
    add_column :users, :last_name,        :string
    add_column :users, :mother_last_name, :string
    add_column :users, :work_phone,       :string
    add_column :users, :home_phone,       :string
    add_column :users, :cell_phone,       :string
  end

  def self.down
  end
end
