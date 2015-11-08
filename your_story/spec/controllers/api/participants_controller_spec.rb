require 'rails_helper'

describe Api::ParticipantsController do
  describe "index" do
    let(:participant_one) {FactoryGirl.create(:participant)}
    let(:participant_two) {FactoryGirl.create(:participant)}
    context "JSON" do
      it "should respond to index action" do
        get :index, format: :json
        expect(response).to be_success
      end

      it "should have pagination" do
        get :index, format: :json, page: 1, page_size: 5
        json = json_response
        expect(json.length).to be <= 5
        expect(json_response).to include(
          :participants, :page, :page_size, :total_pages
          )
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
    let(:participant) {FactoryGirl.create(:participant)}
    it "shows the correct participant" do
      get :show, id: participant.id
      json = json_response
      expect(json.participant.id).to eq participant.id
      expect(json.participant).to include(
        :id, :profile_type, :last_name, :first_name,
        :url, :profile, :local_chapter, :stories_url, :stories,
        :avatars
        )
    end
    it "responds with 404 if not found" do
      get :show, id: "not_a_real_id_haha"
      expect(response.status).to eq 404
    end
  end

  describe "create" do
    context "with valid attributes" do
      it "creates a new contact" do
        params = FactoryGirl.attributes_for(:participant)
        params[:profile_type] = :member_profile
        params[:local_chapter] = params[:local_chapter].id
        params[:profile_attributes] = {
          membership_typ: :team_leader
        }
        expect{
          post :create, format: :json, participant: params
        }.to change(Participant,:count).by(1)
        expect(response.status).to eq 201
      end
    end
    context "with invalid attributes" do
      it "doesnt create a new contact" do
        params = FactoryGirl.attributes_for(:participant)
        params[:profile_type] = :member_profile
        params[:profile_attributes] = {
          membership_typ: :wtf
        }
        expect{
          post :create, format: :json, participant: params
        }.to change(Participant,:count).by(0)
        expect(response.status).to eq 422
      end
    end
  end

  describe "destroy" do
    let(:admin){FactoryGirl.create(:user)}
    let(:participant){FactoryGirl.create(:participant)}
    let(:story){FactoryGirl.create(:story, participant: participant)}

    context "with credentials" do
      before(:each) do
        request.headers['Authorization'] = "Bearer #{admin.token}"
      end
      it "should delete participant" do
        partID = participant.id
        delete :destroy, id: participant.id
        expect(Participant.exists?(partID)).to be false
      end
      it "should delete associated avatars" do
        avatarsID = participant.avatars.map { |a| a.id }
        delete :destroy, id: participant.id
        avatarsID.each { |id| expect(Avatar.exists?(id)).to be false}
      end
      it "should delete associated stories" do
        storyID = story.id
        delete :destroy, id: participant.id
        expect(Story.exists?(storyID)).to be false
      end
    end
    context "without credentials" do
      it "should response with unauthorized" do
        delete :destroy, id: participant.id
        expect(response).to be_unauthorized
      end
    end
  end

end
