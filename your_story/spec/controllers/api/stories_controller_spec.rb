require 'rails_helper'

describe Api::StoriesController do
  describe "index" do
    let(:story_one) {FactoryGirl.create(:story)}
    let(:story_two) {FactoryGirl.create(:story)}
    context "JSON" do
      it "should respond to index action" do
        get :index, format: :json, participant_id: story_one.participant.id
        expect(response).to be_success
        expect(json_response).to include(
          :stories, :page, :page_size, :total_pages
          )
      end

      it "should have pagination" do
        get :index, format: :json, page: 1, page_size: 5, participant_id: story_one.participant.id
        json = json_response
        expect(json.length).to be <= 5
      end
    end

    context "Non json" do
      it "should respond with json anyway" do
        get :index, format: :html, participant_id: story_one.participant.id
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end


  describe "show" do
    let(:story) {FactoryGirl.create(:story)}
    it "shows the correct participant" do
      get :show, id: story.id, participant_id: story.participant.id
      json = json_response
      expect(json.story.id).to eq story.id
      expect(json_response.story).to include(
        :url, :participant_url, :state_url, :id, :title, :highlight,
        :state, :date
        )
    end
    it "responds with 404 if not found" do
      get :show, id: "not_a_real_id_haha", participant_id: story.participant.id
      expect(response.status).to eq 404
    end
    it "responds with 404 if participant not found" do
      get :show, id: story.id, participant_id: "not_a_real_id_haha"
      expect(response.status).to eq 404
    end
  end

  describe "create" do
    context "with valid attributes" do
      it "creates a new contact" do
        params = FactoryGirl.attributes_for(:story)
        params[:state_id] = State.first.id
        expect{
          post :create, story: params, participant_id: params.participant.id
        }.to change(Story, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesnt create a new contact" do
       expect{
          post :create, story: {}, participant_id: FactoryGirl.create(:participant).id
        }.to change(Story, :count).by(0)
      end
    end
  end
end
