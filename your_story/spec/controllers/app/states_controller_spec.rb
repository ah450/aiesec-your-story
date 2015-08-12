require 'rails_helper'

describe Api::StatesController do
  describe "index" do
    let(:state_one) {FactoryGirl.create(:state)}
    let(:state_two) {FactoryGirl.create(:state)}
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
  describe "show" do
    let(:state) {FactoryGirl.create(:state)}
    it "shows the correct participant" do
      get :show, id: state.id
      json = json_response
      expect(json.id).to eq state.id
    end
    it "responds with 404 if not found" do
      get :show, id: "not_a_real_id_haha"
      expect(response.status).to eq 404
    end
  end

end
