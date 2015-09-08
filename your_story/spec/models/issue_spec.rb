require 'rails_helper'

describe Issue do
  let(:factory) {FactoryGirl.create(:issue)}
  it "should have a valid factory" do
    expect(factory).to be_valid
  end
end
