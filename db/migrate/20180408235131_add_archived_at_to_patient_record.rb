class AddArchivedAtToPatientRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :archived_at, :datetime, :null => true, :default => nil
  end
end
