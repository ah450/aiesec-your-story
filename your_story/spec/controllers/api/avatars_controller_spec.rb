require 'rails_helper'

describe Api::AvatarsController do
  let(:participant) { FactoryGirl.create(:participant) }
  let(:file) { fixture_file_upload('lorem.jpg', 'image/jpeg') }
  it "should upload a file" do
    post :create, avatar: {files: [file]} , participant_id: participant.id
    expect(response.status).to eq 201
    expect(json_response.first).to include(
      :url, :filename, :mime_type, :id
      )
  end
end
