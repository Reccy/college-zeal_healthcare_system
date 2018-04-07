class AddFacilityHeadToMedicalFacility < ActiveRecord::Migration[5.1]
  def change
    add_reference :medical_facilities, :facility_head, foreign_key: {to_table: :doctors}
  end
end
