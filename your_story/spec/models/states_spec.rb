require 'rails_helper'

describe State do
  let(:factory) {FactoryGirl.create(:state)}
  it "should have a valid factory" do 
    expect(factory).to be_valid
  end
  context "without default name" do
    let(:state) {FactoryGirl.build(:state, default_name: nil)}
    it "should not be valid" do
      expect(state).to_not be_valid
    end
  end
end