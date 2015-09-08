FactoryGirl.define do
  factory :company do
    name Faker::Company.name
    story {FactoryGirl.create :story}
  end
end
