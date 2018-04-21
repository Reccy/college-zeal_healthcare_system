module Auditor
	require("#{Auditor::Engine.root.join('app','controllers','auditor','audits_controller.rb').to_s}")

	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	# Configure mapping between subject and decorator #
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
	class AuditsController < ApplicationController
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
				"AppointmentRemoved" => AppointmentRemovedReport
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
end
