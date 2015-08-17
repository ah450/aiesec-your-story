require 'rails_helper'

describe Api::ConfigurationsController do
  it "should list configurations" do
    get :index, format: :json
    expect(json_response).to eql Rails.application.config.configuration
  end
end
