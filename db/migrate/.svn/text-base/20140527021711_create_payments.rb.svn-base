class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :patient_id
      t.decimal :importe, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
