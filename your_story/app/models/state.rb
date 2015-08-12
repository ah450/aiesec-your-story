class State < ActiveRecord::Base
  has_many :names, foreign_key: "state_id", class_name: "StateName", dependent: :delete_all
  has_many :stories, dependent: :delete_all
  validates_presence_of :default_name
end
