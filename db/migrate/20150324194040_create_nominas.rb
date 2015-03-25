class CreateNominas < ActiveRecord::Migration
  def self.up
    create_table :nominas do |t|
      t.integer :therapist_id
      t.date :fecha
      t.string :concepto
      t.float :total

      t.timestamps
    end
  end

  def self.down
    drop_table :nominas
  end
end
