class CreateMedicalFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_facilities do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :description, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
