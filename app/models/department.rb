class Department < ApplicationRecord
	validates :name, presence: true
  	belongs_to :medical_facility, required: true
  	belongs_to :department_head, :class_name => 'Doctor', :foreign_key => 'department_head_id', optional: true
end
