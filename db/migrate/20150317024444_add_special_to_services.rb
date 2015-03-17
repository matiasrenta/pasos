class AddSpecialToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :special, :boolean
  end

  def self.down
    remove_column :services, :special
  end
end
