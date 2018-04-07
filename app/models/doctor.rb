class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :owned_facilities, :class_name => "MedicalFacility", :foreign_key => "facility_head_id"

  def full_name
  	return first_name + " " + last_name
  end

  def can_edit_facility?(medical_facility)
    return true if superuser?
    return true if medical_facility.facility_head_id == id
    return false
  end

end
