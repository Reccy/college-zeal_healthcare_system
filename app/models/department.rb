class Department < ApplicationRecord
	validates :name, presence: true
  	belongs_to :medical_facility, required: true
end
