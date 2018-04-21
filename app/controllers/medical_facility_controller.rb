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

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} created a new facility: #{@new_facility.name}.", subject: "FacilityCreated", author: current_doctor.full_name)
	end

	def edit
		@current_facility = MedicalFacility.find(params[:id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_facility?(@current_facility)
	end

	def update
		@current_facility = MedicalFacility.find(params[:id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_facility?(@current_facility)

		if @current_facility.update_attributes(medical_facility_params)

			Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} updated facility: #{@new_facility.name}. Name: (#{old_name} -> #{@current_facility.name}) | Address: (#{old_address} -> #{@current_facility.address}) | Description: (#{old_description} -> #{@current_facility.description})", subject: "FacilityUpdate", author: current_doctor.full_name)

			redirect_to url_for(@current_facility)
		else
			redirect_to "/500.html" and return false
		end
	end

	def show
		@current_facility = MedicalFacility.find(params[:id])
		redirect_to "/403.html" and return false unless current_doctor.can_view_facility?(@current_facility)

		@departments = @current_facility.departments
	end

	def destroy
		redirect_to "/403.html" and return false unless current_doctor.superuser?

		@deleted_facility = MedicalFacility.find(params[:id])
		deleted_facility_name = @deleted_facility
		@deleted_facility.delete

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} destroyed facility #{deleted_facility_name}.", subject: "FacilityDestroyed", author: current_doctor.full_name)

		redirect_to medical_facility_index_path(last_deleted_facility: @deleted_facility.name)
	end

	# Removes the head of the facility
	def remove_facility_head
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_facility?(@current_facility)

		old_facility_head_name = @current_facility.facility_head.full_name
		@current_facility.update_attribute(:facility_head, nil)
		@current_facility.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} removed #{old_facility_head_name} as the head of #{@current_facility.name}.", subject: "FacilityUpdate", author: current_doctor.full_name)

		flash[:success] = 'Successfully removed facility head'
		redirect_back(fallback_location: :root_path)
	end

	# Assigns the head of the facility
	def assign_facility_head
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		redirect_to "/403.html" and return false unless current_doctor.can_edit_facility?(@current_facility)
		redirect_to "/422.html" and return false unless params[:doctor_id] != nil

		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		head = Doctor.find(params[:doctor_id])
		@current_facility.update_attribute(:facility_head, head)
		@current_facility.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} assigned #{head.full_name} as the head of #{@current_facility.name}.", subject: "FacilityUpdate", author: current_doctor.full_name)

		flash[:success] = 'Successfully assigned new facility head'
		redirect_back(fallback_location: :root_path)
	end

	# POST search for Doctors by name or email.
	# Used for AJAX calls
	def search_doctors
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		redirect_to "/403.html" and return false unless current_doctor.can_view_facility?(@current_facility)
		
		doctors = Doctor.where("first_name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query", query: "%#{params[:query]}%").order(:first_name)

		render json: {:doctors => doctors}
	end

	def get_departments
		@current_facility = MedicalFacility.find(params[:medical_facility_id])
		redirect_to "/403.html" and return false unless current_doctor.can_view_facility?(@current_facility)

		departments = @current_facility.departments.all

		render json: {:departments => departments}
	end

	private

	def medical_facility_params
		params.require(:medical_facility).permit(:name, :address, :description, :latitude, :longitude)
	end
end
