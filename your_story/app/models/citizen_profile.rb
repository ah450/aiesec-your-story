class CitizenProfile < ActiveRecord::Base
  has_one :participant, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :participant
end
