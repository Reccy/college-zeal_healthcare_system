class MedicalFacility < ApplicationRecord
	validates :name, presence: true
	validates :address, presence: true
	validates :description, presence: true
	validates :latitude, presence: true
	validates :longitude, presence: true
	validates :facility_type, presence: true
end
