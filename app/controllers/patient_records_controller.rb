class PatientRecordsController < ApplicationController

	# Creates a new patient record
	def create
		@current_patient = Patient.find(params[:patient_id])
		@new_record = PatientRecord.new(title: params[:patient_record][:title], content: params[:patient_record][:content], doctor: current_doctor)
		@current_patient.patient_records << @new_record
		@current_patient.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} created a new record for #{@new_record.patient.full_name} titled \"#{@new_record.title}\": #{@new_record.content}", subject: "RecordUpdate", author: current_doctor.full_name)

		flash[:success] = 'Successfully created record!'
		redirect_back(fallback_location: :root_path)
	end

	# Archives the Patient Record and sets the archive datetime
	def archive_record
		@archived_record = PatientRecord.find(params[:patient_record_id])

		# Don't re-archive an archived record.
		# TODO: Add proper logic here to handle this
		return if @archived_record.is_archived?

		@archived_record.update_attribute(:is_archived, true)
		@archived_record.update_attribute(:archived_at, DateTime.now)
		@archived_record.save!

		Auditor::AuditRecord.create(entry: "#{current_doctor.full_name} archived one of #{@archived_record.patient.full_name.possessive} records titled \"#{@archived_record.title}\": #{@archived_record.content}", subject: "RecordArchival", author: current_doctor.full_name)

		flash[:success] = 'Successfully archived record!'
		redirect_back(fallback_location: :root_path)
	end

end
