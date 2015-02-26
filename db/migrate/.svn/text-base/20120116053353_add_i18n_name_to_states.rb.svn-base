class AddI18nNameToStates < ActiveRecord::Migration
  def self.up
    add_column :states, :i18n_name, :string
    remove_column :states, :name
  end

  def self.down
    remove_column :states, :i18n_name
    add_column :states, :name, :string
  end
end
