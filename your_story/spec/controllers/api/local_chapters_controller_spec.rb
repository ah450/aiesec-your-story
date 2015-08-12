require 'rails_helper'

describe Api::LocalChaptersController do
   describe "index" do
    let(:local_chapter_one) {FactoryGirl.create(:local_chapter)}
    let(:local_chapter_two) {FactoryGirl.create(:local_chapter)}
    context "JSON" do
      it "should respond to index action" do
        get :index, format: :json
        expect(response).to be_success
      end

      it "should have pagination" do 
        get :index, format: :json, page: 1, page_size: 5
        json = json_response
        expect(json.length).to be <= 5
      end
    end

    context "Non json" do
      it "should respond with json anyway" do
        get :index, format: :html
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end
end
