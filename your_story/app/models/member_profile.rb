class MemberProfile < ActiveRecord::Base
  has_one :participant, as: :profile, dependent: :destroy
  belongs_to :local_chapter
  accepts_nested_attributes_for :participant
  enum membership_typ: [:member, :team_leader, :lcvp, :mcvp, :mcp, :ai,
    :facilitator, :ceeder, :congress_comitee, :est]
  validates_presence_of :participant, :local_chapter
end
