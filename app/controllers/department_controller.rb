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

	private 

	def department_params
		params.require(:department).permit(:name, :medical_facility_id)
	end
end
