class AddNroReciboToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :nro_recibo, :integer
  end

  def self.down
    remove_column :payments, :nro_recibo
  end
end
