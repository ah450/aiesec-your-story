class State < ActiveRecord::Base
  has_many :names, foreign_key: "state_id", class_name: "StateName", dependent: :delete_all
  has_many :stories, dependent: :delete_all
  validates_presence_of :default_name, :country
  searchkick text_middle: [:combined_names], callbacks: :async

  def search_data
    {
      combined_names: all_names
    }
  end

  def all_names
    data = names.map { |e| e.name  } | [default_name]
    data.map { |e| "#{e}, #{country}" }
  end

  def self.custom_search(query)
    State.search query do |body|
      body[:query] = {
        dis_max: {
          queries: [
            {
              match: {
                _all: {
                  query: query,
                  fuzziness: 10,
                  prefix_length: 1,
                  boost: 1,
                  max_expansions: 4,
                }
              }
            },
            {
              match: {
                _all: {
                  query: query,
                  operator: "and",
                  fuzziness: 2,
                  prefix_length: 1,
                  boost: 5,
                  max_expansions: 3,
                }
              }
            },
            {
              match: {
                _all: {
                  query: query,
                  operator: "and",
                  boost: 10,
                  analyzer: "searchkick_search"
                }
              }
            }
          ]
        }
      }
    end
  end
end
