class Patient < ApplicationRecord
  	belongs_to :doctor
  	has_many :patient_records
  	has_many :appointments

	def full_name
		return first_name + " " + last_name
	end
end
