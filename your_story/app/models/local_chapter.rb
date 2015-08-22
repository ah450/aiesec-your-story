class LocalChapter < ActiveRecord::Base
  validates_presence_of :name
  has_many :participants, dependent: :delete_all
  paginates_per 10000000
  
  def json_builder
    {
      id: id,
      name: name,
    }
  end

end
