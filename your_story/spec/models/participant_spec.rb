require 'rails_helper'

describe Participant do
  let(:factory) {FactoryGirl.create(:participant)}
  it "has a valid factory" do
    expect(factory).to be_valid
  end
  context "when its first_name is nil" do
    let(:participant) {FactoryGirl.build(:participant, first_name: nil)}
    it 'is not valid' do
      expect(participant).to_not be_valid
    end
  end
  context "when its last_name is nil" do
    let(:participant) {FactoryGirl.build(:participant, last_name: nil)}
    it 'is not valid' do
      expect(participant).to_not be_valid
    end
  end
  context "when its profile is nil" do
    let(:participant) {FactoryGirl.build(:participant, profile: nil)}
    it 'is not valid' do
      expect(participant).to_not be_valid
    end
  end
end