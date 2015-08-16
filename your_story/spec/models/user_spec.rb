require 'rails_helper'

describe User do
  let(:user) {FactoryGirl.build(:user)}
  it "should have a valid factory" do
    expect(user).to be_valid
  end
  describe "Token generation" do
    let(:user) {FactoryGirl.create(:user)}
    it "Should be able to create a token" do
      expect(user.token).to be_a_kind_of(String)
    end
    it "Should be able to retrive by token" do
      token = user.token
      expect(User.find_by_token(token)).to eql user
    end
  end
end
