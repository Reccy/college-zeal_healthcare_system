require_dependency "auditor/application_controller"

module Auditor
	class AuditsController < ApplicationController

		def index
		end

		# Creates an Audit Report and returns it through AJAX
		def create
			@decorator_list = params[:audit_query][:decorator_list].reject { |c| c.empty? }

			audit_options = get_options

			audit = SimpleReport.new()
			@decorator_list.each do |option|
				if audit_options[option].nil? == false
					audit = audit_options[option].new(audit)
				end
			end

			report = audit.get_report.sort_by {|obj| obj.created_at}
			report = report.reverse

			render json: {
				content:
					render_to_string(
						partial: "audit_card_container",
						formats: :html,
						layout: false,
						locals: {report: report}
					)
			}
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
end
