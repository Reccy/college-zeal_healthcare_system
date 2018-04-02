class MedicalFacilityController < ApplicationController
	before_action :authenticate_doctor!

	def index
	end
end
