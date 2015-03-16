class AddFixedTherapyIdToTimeRanges < ActiveRecord::Migration
  def self.up
    add_column :time_ranges, :fixed_therapy_id, :integer
  end

  def self.down
    remove_column :time_ranges, :fixed_therapy_id
  end
end
