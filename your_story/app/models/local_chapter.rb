class LocalChapter < ActiveRecord::Base
  validates_presence_of :name
  has_many :member_profile, dependent: :delete_all
  include Elasticsearch::Model
end
