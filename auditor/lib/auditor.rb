require "auditor/engine"

module Auditor
	auditor_ran = false

	# Perform check after the ActiveRecord connection is made
	ActiveRecord::Base::after_initialize do
		unless auditor_ran
			auditor_ran = true

			puts "[AUDITOR] Initializing Auditor."

			# Check if the auditor table exists
			if ActiveRecord::Base.connection.table_exists? 'auditor_audit_records'
				puts "[AUDITOR] Auditor table exists."

				# Check if the initial audit has been created, else create the audit
				if AuditRecord.where(subject: "AppConfig").empty?
					Auditor::AuditRecord.create(entry: "Auditor has been successfully installed on #{Time.now.strftime('%Y-%m-%e %k:%M:%S %Z %z')}", subject: "AppConfig", author: "Auditor")
					puts "[AUDITOR] Auditor configured."
				else
					puts "[AUDITOR] Auditor was already configured."
				end
				puts "[AUDITOR] Auditor initialized."
			else
				puts "[AUDITOR] ERROR: Auditor table does not exist! Please migrate the database and restart the server!"
			end
		end
	end
end
