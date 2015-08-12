class Story < ActiveRecord::Base
  belongs_to :participant
  belongs_to :state
end
