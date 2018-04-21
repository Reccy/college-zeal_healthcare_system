class AppointmentsController < ApplicationController
	before_action :authenticate_doctor!

	def cancel_appointment
		@current_patient = Patient.find(params[:patient_id])
		@del_appointment = current_doctor.appointments.find(params[:appointment_id])
		@del_appointment.delete

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} removed appointment with #{@del_appointment.patient.full_name} at #{@del_appointment.scheduled}.", subject: "AppointmentRemoved", author: current_doctor.full_name)

		flash[:success] = "Successfully Removed Appointment!"
		redirect_back(fallback_location: :root_path)
	end

end
