class DepartmentController < ApplicationController
	def create
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		begin
			@current_facility.departments.create(department_params)
			@current_facility.save!()
			flash[:success] = 'New department created'
		rescue => ex
			flash[:danger] = 'Failed to create new department'
		end
		
		redirect_back(fallback_location: :root_path)
	end

	def show
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		@current_department = @current_facility.departments.find(params[:id])
	end

	# Removes the head of the department
	def remove_department_head
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		@current_department = @current_facility.departments.find(params[:department_id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_department?(@current_department)

		@current_department.update_attribute(:department_head, nil)
		@current_department.save!

		flash[:success] = 'Successfully removed department head'
		redirect_back(fallback_location: :root_path)
	end

	# Assigns the head of the department
	def assign_department_head
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		@current_department = @current_facility.departments.find(params[:department_id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_department?(@current_department)
		redirect_to "/422.html" and return false unless params[:doctor_id] != nil

		head = Doctor.find(params[:doctor_id])

		@current_department.update_attribute(:department_head, head)
		@current_department.save!

		flash[:success] = 'Successfully assigned new department head'
		redirect_back(fallback_location: :root_path)
	end

	private 

	def department_params
		params.require(:department).permit(:name, :medical_facility_id)
	end
end
