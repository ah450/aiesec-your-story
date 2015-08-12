require 'rails_helper'

describe StateName do
  let(:factory) {FactoryGirl.create(:state_name)}
  it "should have a valid factory" do 
    expect(factory).to be_valid
  end
  context "without name" do
    let(:state_name) {FactoryGirl.build(:state_name, name: nil)}
    it "should not be valid" do
      expect(state_name).to_not be_valid
    end
  end
end