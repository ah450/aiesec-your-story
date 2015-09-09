class Company < ActiveRecord::Base
  belongs_to :story
  validates_presence_of :name, :story, on: :update
end
