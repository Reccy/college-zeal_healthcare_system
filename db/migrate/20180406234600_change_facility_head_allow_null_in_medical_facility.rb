class ChangeFacilityHeadAllowNullInMedicalFacility < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :medical_facilities, :facility_head_id, true
  end
end
