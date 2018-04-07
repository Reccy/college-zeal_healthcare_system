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
end
