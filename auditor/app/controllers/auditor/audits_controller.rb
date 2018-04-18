require_dependency "auditor/application_controller"

module Auditor

	class AuditsController < ApplicationController

		def index
		end

		# Creates an Audit Report and returns it through AJAX
		def create
			@decorator_list = params[:audit_query][:decorator_list].reject { |c| c.empty? }

			audit_options = {
				"AppConfig" => AppConfigReport,
				"RecordUpdate" => RecordUpdateReport,
				"RecordArchival" => RecordArchivalReport,
				"PatientCreated" => PatientCreatedReport,
				"PatientReferred" => PatientReferredReport,
				"PatientViewed" => PatientViewedReport
			}

			audit = SimpleReport.new()
			@decorator_list.each do |option|
				if audit_options[option].nil? == false
					audit = audit_options[option].new(audit)
				end
			end

			report = audit.get_report.sort_by {|obj| obj.created_at}
			report = report.reverse

			render json: report.to_json
		end

	end

	# Decorator pattern for searching the Audit Record
	class SimpleReport

		attr_accessor :search_subjects

		def initialize()
			@search_subjects = []
		end

		def get_report
			return Auditor::AuditRecord.all.where(subject: @search_subjects).order('created_at DESC')
		end
	end

	class ReportDecorator < SimpleDelegator
		def initialize(original_report)
			@original_report = original_report
			super
		end
	end

	class AppConfigReport < ReportDecorator
		def get_report
			@original_report.search_subjects.push("AppConfig")
			return @original_report.get_report
		end
	end

	# EXTRACT THESE TO THE MAIN APP WHEN DONE LOL

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
