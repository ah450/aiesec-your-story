require 'rails_helper'

describe CitizenProfile do
  let(:factory) {FactoryGirl.create(:citizen_profile)}
  it "has a valid factory" do
    expect(factory).to be_valid
  end
  it "can reference participant" do
    expect(factory.participant).to_not be(nil)
  end
end