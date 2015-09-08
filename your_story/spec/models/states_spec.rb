require 'rails_helper'

describe State do
  let(:factory) {FactoryGirl.create(:state)}
  it "should have a valid factory" do
    expect(factory).to be_valid
  end
  it 'should have a json builder' do
    expect(factory.json_builder).to include :id, :name, :country
  end
  context "without name" do
    let(:state) {FactoryGirl.build(:state, name: nil)}
    it "should not be valid" do
      expect(state).to_not be_valid
    end
  end
end