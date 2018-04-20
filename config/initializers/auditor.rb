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
				"PatientViewed" => PatientViewedReport
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
end
