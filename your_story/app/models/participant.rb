class Participant < ActiveRecord::Base
  has_many :stories, dependent: :destroy
  belongs_to :profile, polymorphic: true, dependent: :destroy
  belongs_to :local_chapter
  has_many :avatars, dependent: :delete_all
  accepts_nested_attributes_for :profile
  validates_presence_of :first_name, :last_name, :profile
  paginates_per 10000000

  def json_builder
    json = as_json(
      except: [:profile_id, :local_chapter_id],
      include: [:profile]
      )
    json['profile_type'] = json['profile_type'].underscore
    json.merge({
      local_chapter: local_chapter.json_builder,
      avatars: avatars.map { |e| e.json_builder },
      stories: stories.map { |e| e.json_builder }
      })
  end

  def self.profile_types_json
    {
      member_profile: :member_profile,
      talent_profile: :talent_profile,
      citizen_profile: :citizen_profile
    }
  end

end
