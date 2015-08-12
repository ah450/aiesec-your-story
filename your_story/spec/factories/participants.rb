FactoryGirl.define do
  factory :participant do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    profile {FactoryGirl.create(:member_profile)}
  end
end
