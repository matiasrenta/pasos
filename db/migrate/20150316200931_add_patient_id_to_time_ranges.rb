class AddPatientIdToTimeRanges < ActiveRecord::Migration
  def self.up
    add_column :time_ranges, :patient_id, :integer
  end

  def self.down
    remove_column :time_ranges, :patient_id
  end
end
