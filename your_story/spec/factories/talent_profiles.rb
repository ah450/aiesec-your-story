FactoryGirl.define do
  factory :talent_profile do
    outgoing false
    after(:build) do |profile|
      profile.participant ||= FactoryGirl.build(:participant, profile: profile)
    end
  end

end
