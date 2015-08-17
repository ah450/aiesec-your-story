require 'rails_helper'

describe Api::TokensController do
  let(:user) { FactoryGirl.create(:user) }
  it "Should have a default duration" do 
    post :create, token: {email: user.email, password: user.password}
    expect(User.find_by_token(json_response[:token])).to eql user
  end
end
