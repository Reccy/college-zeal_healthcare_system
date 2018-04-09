class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :owned_facilities, :class_name => "MedicalFacility", :foreign_key => "facility_head_id"
  has_many :owned_departments, :class_name => "Department", :foreign_key => "department_head_id"
  has_many :patients
  has_many :patient_records
  has_many :appointments
  belongs_to :workplace, :class_name => "Department", :foreign_key => "workplace_id", optional: true

  def full_name
  	return first_name + " " + last_name
  end

  def can_edit_facility?(medical_facility)
    return true if superuser?
    return true if medical_facility.facility_head_id == id
    return false
  end

  def can_view_facility?(medical_facility)
    # TODO: Add view check here
    return true
    return can_edit_facility?(medical_facility)
  end

  def can_edit_department?(department)
    return true if can_edit_facility?(department.medical_facility)
    return true if department.department_head_id == id
    return false
  end
end
