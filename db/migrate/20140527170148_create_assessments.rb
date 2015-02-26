class CreateAssessments < ActiveRecord::Migration
  def self.up
    create_table :assessments do |t|
      t.integer :patient_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :assessments
  end
end
