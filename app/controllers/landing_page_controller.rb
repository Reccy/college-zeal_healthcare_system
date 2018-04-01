class LandingPageController < ApplicationController
	layout 'landing_page'

	def view
		@user = current_doctor
	end
end
