class LocalChapter < ActiveRecord::Base
  validates_presence_of :name
  has_many :participants, dependent: :delete_all
  searchkick text_middle: ['name'], autocomplete: ['name'], callbacks: :async
  
  def search_data
    as_json(only: [:name])
  end

end
