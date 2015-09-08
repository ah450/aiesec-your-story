require 'rails_helper'

describe Company do
  let(:factory) {FactoryGirl.create(:company)}
  it "should have a valid factory" do
    expect(factory).to be_valid
  end
end
