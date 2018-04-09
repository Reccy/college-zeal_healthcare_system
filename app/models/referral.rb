class Referral < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :department
end
