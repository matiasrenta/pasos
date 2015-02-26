class CreatePresences < ActiveRecord::Migration
  def self.up
    create_table :presences do |t|
      t.integer :therapy_id
      t.datetime :fecha_hora
      t.decimal :importe, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :presences
  end
end
