class AddPresenceableToPresences < ActiveRecord::Migration
  def self.up
    add_column :presences, :presenscable_id, :integer
    add_column :presences, :presenceable_type, :string
  end

  def self.down
    remove_column :presences, :presenceable_type
    remove_column :presences, :presenscable_id
  end
end
