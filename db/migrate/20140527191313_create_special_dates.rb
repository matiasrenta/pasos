class CreateSpecialDates < ActiveRecord::Migration
  def self.up
    create_table :special_dates do |t|
      t.integer :therapy_id
      t.datetime :fecha_hora
      t.boolean :cancellation

      t.timestamps
    end
  end

  def self.down
    drop_table :special_dates
  end
end
