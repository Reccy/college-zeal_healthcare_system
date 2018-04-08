class Patient < ApplicationRecord
  	belongs_to :doctor

	def full_name
		return first_name + " " + last_name
	end
end
