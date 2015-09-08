FactoryGirl.define do
  factory :issue do
    name Faker::Name.name
    story {FactoryGirl.create :story}
  end
end
