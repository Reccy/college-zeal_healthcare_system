class MedicalFacility < ApplicationRecord
	validates :name, presence: true
	validates :address, presence: true
	validates :description, presence: true
	validates :latitude, presence: true
	validates :longitude, presence: true
	validates :facility_type, presence: true

	belongs_to :facility_head, :class_name => 'Doctor', :foreign_key => 'facility_head_id', optional: true
end
