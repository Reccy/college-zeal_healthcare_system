class ReferralsController < ApplicationController
	before_action :authenticate_doctor!

	def create
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		@current_department = @current_facility.departments.find(params[:department_id])
		@referred_patient = current_doctor.patients.find(params[:referral][:patient_id])

		@current_department.referrals << Referral.create(doctor: current_doctor, reason: params[:referral][:reason], patient: @referred_patient)
		@current_department.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} referred #{@referred_patient.full_name} to #{@current_department.medical_facility.name.possessive} #{@current_department.name} with the reason: #{params[:referral][:reason]}", subject: "PatientReferred", author: current_doctor.full_name)

		flash[:success] = "Successfully created deferral!"
		redirect_back(fallback_location: :root_path)
	end

end
