FactoryGirl.define do
  factory :member_profile do
    membership_typ 1
    after(:build) do |profile|
      profile.participant ||= FactoryGirl.build(:participant, profile: profile)
    end
  end
end
