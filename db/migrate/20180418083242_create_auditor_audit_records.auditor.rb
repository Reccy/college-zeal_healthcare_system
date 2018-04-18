# This migration comes from auditor (originally 20180418073624)
class CreateAuditorAuditRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :auditor_audit_records do |t|
      t.string :entry
      t.string :subject
      t.string :author

      t.timestamps
    end
  end
end
