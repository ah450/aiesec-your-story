class State < ActiveRecord::Base
  has_many :names, foreign_key: "state_id", class_name: "StateName", dependent: :delete_all
  has_many :stories, dependent: :delete_all
  validates_presence_of :default_name, :country
  paginates_per 10000000

  def json_builder
    {
      default_name: default_name,
      id: id,
      country: country,
      names: names
    }
  end
end
