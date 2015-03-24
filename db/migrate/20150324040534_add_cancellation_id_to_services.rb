class AddCancellationIdToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :cancellation_id, :integer
  end

  def self.down
    remove_column :services, :cancellation_id
  end
end
