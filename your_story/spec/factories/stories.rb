FactoryGirl.define do
  factory :story do
    title Faker::Name.title
    highlight Faker::Lorem.paragraph
    date  Faker::Date.between(2.years.ago, Time.now)
    participant {FactoryGirl.create(:participant)}
    state {FactoryGirl.create(:state)}
  end
end
