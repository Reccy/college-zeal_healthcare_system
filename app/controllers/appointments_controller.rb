class AppointmentsController < ApplicationController
	before_action :authenticate_doctor!

	def cancel_appointment
		@current_patient = Patient.find(params[:patient_id])
		@del_appointment = current_doctor.appointments.find(params[:appointment_id])
		@del_appointment.delete

		flash[:success] = "Successfully Removed Appointment!"
		redirect_back(fallback_location: :root_path)
	end

end
