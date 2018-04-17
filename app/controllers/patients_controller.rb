class PatientsController < ApplicationController
	before_action :authenticate_doctor!

	def index
	end

	def create
		@new_patient = Patient.new(patient_params)
		@new_patient.doctor = current_doctor
		@new_patient.save!

		flash[:success] = "Successfully Created Patient \"#{@new_patient.full_name}\"!"
		redirect_back(fallback_location: :root_path)
	end

	def update
		@current_patient = Patient.find(params[:id])

		@current_patient.update_attribute(:phone_number, params[:patient][:phone_number])
		@current_patient.update_attribute(:email, params[:patient][:email])
		@current_patient.update_attribute(:address, params[:patient][:address])

		@current_patient.save!

		flash[:success] = "Successfully Updated Patient Information!"
		redirect_back(fallback_location: :root_path)
	end

	def create_appointment
		@current_patient = Patient.find(params[:patient_id])
		@new_appointment = Appointment.create(doctor: current_doctor, patient: @current_patient, reason: params[:appointment][:reason], scheduled: params[:appointment][:scheduled])
		@new_appointment.save!

		flash[:success] = "Successfully Created Appointment!"
		redirect_back(fallback_location: :root_path)
	end

	def create_appointment_from_referral
		@current_patient = Patient.find(params[:patient_id])
		@new_appointment = Appointment.create(doctor: current_doctor, patient: @current_patient, reason: params[:appointment][:reason], scheduled: params[:appointment][:scheduled])
		@from_referral = Referral.find(params[:appointment][:referral_id])
		@new_appointment.save!
		@from_referral.delete

		flash[:success] = "Successfully Created Appointment!"
		redirect_back(fallback_location: :root_path)
	end

	def assign_doctor
		@current_patient = Patient.find(params[:patient_id])
		@new_doctor = Doctor.find(params[:patient][:doctor_id])

		@current_patient.update_attribute(:doctor, @new_doctor)

		flash[:success] = "Successfully Updated \"#{@current_patient.full_name}\" Doctor!"
		redirect_back(fallback_location: :root_path)
	end

	def show
		@current_patient = Patient.find(params[:id])
	end

	private

	def patient_params
		params.require(:patient).permit(:first_name, :last_name)
	end
end
