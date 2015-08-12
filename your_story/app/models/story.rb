class Story < ActiveRecord::Base
  belongs_to :participant
  belongs_to :state
  validates_presence_of :title, :highlight, :participant, :state, :date
end
