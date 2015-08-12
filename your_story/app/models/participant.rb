class Participant < ActiveRecord::Base
  has_many :stories
  belongs_to :profile, polymorphic: true
end
