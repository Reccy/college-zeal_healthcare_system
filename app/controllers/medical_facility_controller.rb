class MedicalFacilityController < ApplicationController
	before_action :authenticate_doctor!

	def index
		@deleted_facility_name = params[:last_deleted_facility]
		@medical_facilities = MedicalFacility.select('id, name, address, description, latitude, longitude, facility_type').all;
	end

	def create
		redirect_to "/403.html" and return false unless current_doctor.superuser?

		@new_facility = MedicalFacility.new(medical_facility_params)
		@save_successful = @new_facility.save()
	end

	def edit
		redirect_to "/403.html" and return false unless current_doctor.superuser?

		@current_facility = MedicalFacility.find(params[:id])
	end

	def update
		redirect_to "/403.html" and return false unless current_doctor.superuser?

		@current_facility = MedicalFacility.find(params[:id])

		if @current_facility.update_attributes(medical_facility_params)
			redirect_to url_for(@current_facility)
		else
			redirect_to "/500.html" and return false
		end
	end

	def show
		@current_facility = MedicalFacility.find(params[:id])
	end

	def destroy
		redirect_to "/403.html" and return false unless current_doctor.superuser?

		@deleted_facility = MedicalFacility.find(params[:id])
		@deleted_facility.delete
		redirect_to medical_facility_index_path(last_deleted_facility: @deleted_facility.name)
	end

	private

	def medical_facility_params
		params.require(:medical_facility).permit(:name, :address, :description, :latitude, :longitude)
	end
end
