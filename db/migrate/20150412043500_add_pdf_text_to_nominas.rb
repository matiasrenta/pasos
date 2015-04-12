class AddPdfTextToNominas < ActiveRecord::Migration
  def self.up
    add_column :nominas, :pdf_text, :text
  end

  def self.down
    remove_column :nominas, :pdf_text
  end
end
