class CreateDaylyServiceCreations < ActiveRecord::Migration
  def self.up
    create_table :dayly_service_creations do |t|
      t.date :last_creation

      t.timestamps
    end
  end

  def self.down
    drop_table :dayly_service_creations
  end
end
