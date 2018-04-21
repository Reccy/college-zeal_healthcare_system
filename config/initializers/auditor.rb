module Auditor
	require("#{Auditor::Engine.root.join('app','controllers','auditor','audits_controller.rb').to_s}")

	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Configure mapping between subject and decorator #
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	class AuditsController < ApplicationController
		before_action :authenticate_superuser!

		# Check to ensure that only the superusers can view the audit log
		def authenticate_superuser!
			return if current_doctor.superuser?
			redirect_to "/403.html"
		end

		def get_options

			audit_options = {
				"AppConfig" => AppConfigReport,
				"RecordUpdate" => RecordUpdateReport,
				"RecordArchival" => RecordArchivalReport,
				"PatientCreated" => PatientCreatedReport,
				"PatientReferred" => PatientReferredReport,
				"PatientViewed" => PatientViewedReport,
				"PatientUpdate" => PatientUpdateReport,
				"DoctorAssignment" => DoctorAssignmentReport,
				"AppointmentCreated" => AppointmentCreatedReport,
				"AppointmentRemoved" => AppointmentRemovedReport,
				"FacilityCreated" => FacilityCreatedReport,
				"FacilityUpdate" => FacilityUpdateReport,
				"FacilityDestroyed" => FacilityDestroyedReport,
				"DepartmentCreated" => DepartmentCreatedReport,
				"DepartmentUpdate" => DepartmentUpdatedReport
			}

		end
	end

	# ~~~~~~~~~~ #
	# Decorators #
	# ~~~~~~~~~~ #
	class RecordUpdateReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("RecordUpdate")
			return @original_report.get_report
		end
	end

	class RecordArchivalReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("RecordArchival")
			return @original_report.get_report
		end
	end

	class PatientCreatedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("PatientCreated")
			return @original_report.get_report
		end
	end

	class PatientReferredReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("PatientReferred")
			return @original_report.get_report
		end
	end

	class PatientViewedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("PatientViewed")
			return @original_report.get_report
		end
	end

	class PatientUpdateReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("PatientUpdate")
			return @original_report.get_report
		end
	end

	class DoctorAssignmentReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("DoctorAssignment")
			return @original_report.get_report
		end
	end

	class AppointmentCreatedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("AppointmentCreated")
			return @original_report.get_report
		end
	end

	class AppointmentRemovedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("AppointmentRemoved")
			return @original_report.get_report
		end
	end

	class FacilityCreatedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("FacilityCreated")
			return @original_report.get_report
		end
	end

	class FacilityUpdateReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("FacilityUpdate")
			return @original_report.get_report
		end
	end

	class FacilityDestroyedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("FacilityDestroyed")
			return @original_report.get_report
		end
	end

	class DepartmentCreatedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("DepartmentCreated")
			return @original_report.get_report
		end
	end

	class DepartmentUpdatedReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("DepartmentUpdate")
			return @original_report.get_report
		end
	end
end
