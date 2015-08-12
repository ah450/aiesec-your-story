class State < ActiveRecord::Base
  has_many :names, foreign_key: "state_id", class_name: "StateName"
  has_many :stories
end
