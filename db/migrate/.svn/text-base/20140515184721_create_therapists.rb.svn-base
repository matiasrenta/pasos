class CreateTherapists < ActiveRecord::Migration
  def self.up
    create_table :therapists do |t|
      t.string :nombre
      t.integer :state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :therapists
  end
end
