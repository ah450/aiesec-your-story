class MemberProfile < ActiveRecord::Base
  has_one :participant, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :participant
  enum membership_typ: [:member, :team_leader, :lcvp, :lcp, :mcvp, :mcp, :ai,
    :facilitator, :chair, :ceeder, :congress_comittee, :nst]
  validates_presence_of :participant
end
