class DoctorsController < ApplicationController
	before_action :authenticate_doctor!

	def index
		@doctors = Doctor.all
	end

	def show
		@this_doctor = Doctor.find(params[:id])
	end

	def fire
		begin
			@current_facility = MedicalFacility.find(params[:medical_facility_id])
			@current_department = @current_facility.departments.find(params[:department_id])
			@fired_doctor = @current_department.employees.find(params[:doctor_id])
			redirect_to "/403.html" and return false unless current_doctor.can_edit_department?(@current_department)

			@fired_doctor.update_attribute(:workplace, nil)
		rescue Exception => e
			flash[:danger] = 'Failed to fire employee.'
			redirect_back(fallback_location: :root_path)
		end
		
		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} fired #{@fired_doctor.full_name} from #{@current_facility.name}.", subject: "DepartmentUpdate", author: current_doctor.full_name)

		flash[:success] = 'Successfully fired!'
		redirect_back(fallback_location: :root_path)
	end
end
