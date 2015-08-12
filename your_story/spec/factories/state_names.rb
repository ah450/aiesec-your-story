FactoryGirl.define do
  factory :state_name do
    name Faker::Address.state
    state {FactoryGirl.create(:state)}
  end
end
