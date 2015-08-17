class LocalChapter < ActiveRecord::Base
  validates_presence_of :name
  has_many :participants, dependent: :delete_all
  searchkick word_middle: ['name'], callbacks: :async
  
  def search_data
    as_json(only: [:name])
  end

  def json_builder
    {
      id: id,
      name: name,
    }
  end

end
