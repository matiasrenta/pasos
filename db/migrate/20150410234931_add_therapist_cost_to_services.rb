class AddTherapistCostToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :therapist_cost, :float
  end

  def self.down
    remove_column :services, :therapist_cost
  end
end
