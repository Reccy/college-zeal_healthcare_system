class CreatePatientRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_records do |t|
      t.belongs_to :patient, foreign_key: true
      t.belongs_to :doctor, foreign_key: true
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
