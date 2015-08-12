FactoryGirl.define do
  factory :state do
    country Faker::Address.country
    default_name Faker::Address.state
    lat  Faker::Address.latitude.to_f
    lng Faker::Address.longitude.to_f
  end
end
