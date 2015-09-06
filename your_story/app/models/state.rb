class State < ActiveRecord::Base
  has_many :stories
  validates_presence_of :name, :country
  paginates_per 10000000

  def json_builder
    {
      name: name,
      id: id,
      country: country
    }
  end
end
