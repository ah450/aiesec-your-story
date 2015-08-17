FactoryGirl.define do
  factory :state do
    country Faker::Address.country
    default_name Faker::Address.state
    lat  Faker::Address.latitude.to_f
    lng Faker::Address.longitude.to_f
    after(:create) {|state| State.reindex}
  end
end
