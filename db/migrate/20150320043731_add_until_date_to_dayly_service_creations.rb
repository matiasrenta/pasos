class AddUntilDateToDaylyServiceCreations < ActiveRecord::Migration
  def self.up
    add_column :dayly_service_creations, :until_date, :date
  end

  def self.down
    remove_column :dayly_service_creations, :until_date
  end
end
