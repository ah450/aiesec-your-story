require 'rails_helper'

describe Avatar do
  let(:factory) {FactoryGirl.build(:avatar)}
  it "Should have a valid factor" do 
    expect(factory).to be_valid
  end
end
