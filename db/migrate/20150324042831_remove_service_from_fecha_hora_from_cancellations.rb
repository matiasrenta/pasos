class RemoveServiceFromFechaHoraFromCancellations < ActiveRecord::Migration
  def self.up
    remove_column :cancellations, :service_from_fecha_hora
  end

  def self.down
  end
end
