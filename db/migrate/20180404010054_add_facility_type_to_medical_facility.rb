class AddFacilityTypeToMedicalFacility < ActiveRecord::Migration[5.1]
  def change
    add_column :medical_facilities, :facility_type, :string, null: false, default: "Clinic"
  end
end
