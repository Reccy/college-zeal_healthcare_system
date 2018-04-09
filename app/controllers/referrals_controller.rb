class ReferralsController < ApplicationController
	before_action :authenticate_doctor!

	def create
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		@current_department = @current_facility.departments.find(params[:department_id])
		@referred_patient = current_doctor.patients.find(params[:referral][:patient_id])

		@current_department.referrals << Referral.create(doctor: current_doctor, reason: params[:referral][:reason], patient: @referred_patient)
		@current_department.save!

		flash[:success] = "Successfully created deferral!"
		redirect_back(fallback_location: :root_path)
	end

end
