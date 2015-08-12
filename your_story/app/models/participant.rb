class Participant < ActiveRecord::Base
  has_many :stories, dependent: :destroy
  belongs_to :profile, polymorphic: true, dependent: :destroy
  accepts_nested_attributes_for :profile
  validates_presence_of :first_name, :last_name, :profile
  paginates_per 50
end
