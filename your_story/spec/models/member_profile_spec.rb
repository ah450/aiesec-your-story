require 'rails_helper'

describe MemberProfile do
  let(:factory) {FactoryGirl.create(:member_profile)}
  it "has a valid factory" do
    expect(factory).to be_valid
  end
  it "can reference participant" do
    expect(factory.participant).to_not be(nil)
  end
end