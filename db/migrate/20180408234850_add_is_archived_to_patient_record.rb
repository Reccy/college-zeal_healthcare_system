class AddIsArchivedToPatientRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :is_archived, :boolean, :null => false, :default => false
  end
end
