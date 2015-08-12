require 'rails_helper'

describe Story do
  let(:factory) {FactoryGirl.create(:story)}
  it "should have a valid factory" do 
    expect(factory).to be_valid
  end
  it "should be able to reference state" do
    expect(factory.state).to_not be(nil)
  end
  it "should be able to reference participant" do
    expect(factory.participant).to_not be(nil)
  end
  context "when its state is nil" do 
    let(:story) {FactoryGirl.build(:story, state: nil)}
    it "should not be valid" do
      expect(story).to_not be_valid
    end
  end

  context "when its participant is nil" do 
    let(:story) {FactoryGirl.build(:story, participant: nil)}
    it "should not be valid" do
      expect(story).to_not be_valid
    end
  end

  context "when its date is nil" do 
    let(:story) {FactoryGirl.build(:story, date: nil)}
    it "should not be valid" do
      expect(story).to_not be_valid
    end
  end

  context "when its title is nil" do 
    let(:story) {FactoryGirl.build(:story, title: nil)}
    it "should not be valid" do
      expect(story).to_not be_valid
    end
  end

  context "when its highlight is nil" do 
    let(:story) {FactoryGirl.build(:story, highlight: nil)}
    it "should not be valid" do
      expect(story).to_not be_valid
    end
  end

end
