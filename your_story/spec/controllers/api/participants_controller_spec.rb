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
      end
    end

    context "Non json" do
      it "should respond with json anyway" do
        get :index, format: :html
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end

  describe "destroy" do
    let(:participant) {FactoryGirl.create(:participant)}
    it "Should delete the participant" do
      expect(MemberProfile.exists?(participant.profile.id)).to be true
      delete :destroy, id: participant.id
      expect(Participant.exists?(participant.id)).to be false
      expect(MemberProfile.exists?(participant.profile.id)).to be false
    end
  end

  describe "show" do
    let(:participant) {FactoryGirl.create(:participant)}
    it "shows the correct participant" do
      get :show, id: participant.id
      json = json_response
      expect(json.id).to eq participant.id
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
        params[:type] = :member_profile
        params[:profile_attributes] = {
          membership_typ: :team_leader,
          local_chapter: LocalChapter.first.id
        }
        expect{
          post :create, participant: params
        }.to change(Participant,:count).by(1)
      end
    end
    context "with invalid attributes" do
      it "doesnt create a new contact" do
        params = FactoryGirl.attributes_for(:participant)
        params[:type] = :member_profile
        params[:profile_attributes] = {
          membership_typ: :wtf,
          local_chapter: LocalChapter.first.id
        }
        expect{
          post :create, participant: params
        }.to change(Participant,:count).by(0)
        expect(response.status).to eq 422
      end
    end
  end

end
