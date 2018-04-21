class PatientsController < ApplicationController
	before_action :authenticate_doctor!

	def index
	end

	def create
		@new_patient = Patient.new(patient_params)
		@new_patient.doctor = current_doctor
		@new_patient.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} created #{@new_patient.full_name.possessive} record", subject: "PatientCreated", author: current_doctor.full_name)

		flash[:success] = "Successfully Created Patient \"#{@new_patient.full_name}\"!"
		redirect_back(fallback_location: :root_path)
	end

	def update
		@current_patient = Patient.find(params[:id])

		old_phone_number = @current_patient.phone_number
		old_email = @current_patient.email
		old_address = @current_patient.address

		@current_patient.update_attribute(:phone_number, params[:patient][:phone_number])
		@current_patient.update_attribute(:email, params[:patient][:email])
		@current_patient.update_attribute(:address, params[:patient][:address])

		@current_patient.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} updated #{@current_patient.full_name.possessive} profile. Phone Number: (#{old_phone_number} -> #{@current_patient.phone_number}) | Email: (#{old_email} -> #{@current_patient.email}) | Address: (#{old_address} -> #{@current_patient.address})", subject: "PatientUpdate", author: @current_doctor.full_name)

		flash[:success] = "Successfully Updated Patient Information!"
		redirect_back(fallback_location: :root_path)
	end

	def create_appointment
		@current_patient = Patient.find(params[:patient_id])
		@new_appointment = Appointment.create(doctor: current_doctor, patient: @current_patient, reason: params[:appointment][:reason], scheduled: params[:appointment][:scheduled])
		@new_appointment.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} created an appointment at #{@new_appointment.scheduled} between #{@new_appointment.doctor.full_name} and #{@new_appointment.patient.full_name} with the following reason: #{@new_appointment.reason}", subject: "AppointmentCreated", author: @current_doctor.full_name)

		flash[:success] = "Successfully Created Appointment!"
		redirect_back(fallback_location: :root_path)
	end

	def create_appointment_from_referral
		@current_patient = Patient.find(params[:patient_id])
		@new_appointment = Appointment.create(doctor: current_doctor, patient: @current_patient, reason: params[:appointment][:reason], scheduled: params[:appointment][:scheduled])
		@from_referral = Referral.find(params[:appointment][:referral_id])
		@new_appointment.save!
		@from_referral.delete

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} created an appointment from a referral by #{@from_referral.doctor.full_name} in the department #{@from_referral.department.name} at #{@new_appointment.scheduled} between #{@new_appointment.doctor.full_name} and #{@new_appointment.patient.full_name} with the following reason: #{@new_appointment.reason}", subject: "AppointmentCreated", author: @current_doctor.full_name)

		flash[:success] = "Successfully Created Appointment!"
		redirect_back(fallback_location: :root_path)
	end

	def assign_doctor
		@current_patient = Patient.find(params[:patient_id])
		@new_doctor = Doctor.find(params[:patient][:doctor_id])
		@previous_doctor = @current_patient.doctor

		@current_patient.update_attribute(:doctor, @new_doctor)

		if @previous_doctor.nil?
			Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} assigned #{@current_patient.full_name.possessive} doctor to #{@new_doctor.full_name}", subject: "DoctorAssignment", author: @current_doctor.full_name)
		else
			Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} assigned #{@current_patient.full_name.possessive} doctor to #{@new_doctor.full_name}. Previous doctor: #{@previous_doctor.full_name}", subject: "DoctorAssignment", author: @current_doctor.full_name)
		end

		flash[:success] = "Successfully Updated \"#{@current_patient.full_name}\" Doctor!"
		redirect_back(fallback_location: :root_path)
	end

	def show
		@current_patient = Patient.find(params[:id])

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} viewed #{@current_patient.full_name.possessive} record", subject: "PatientViewed", author: current_doctor.full_name)
	end

	private

	def patient_params
		params.require(:patient).permit(:first_name, :last_name)
	end
end
