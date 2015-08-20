require 'rails_helper'


describe Api::StatesController do
  describe "index" do
    let(:state_one) { FactoryGirl.create(:state) }
    let(:state_two) { FactoryGirl.create(:state) }

    context "JSON" do
      it 'should respond to index action' do
        get :index, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
        expect(response).to be_success
        expect(json_response.states).to be_an_instance_of Array
      end

      it "should have show" do
        get :show, format: :json, id: state_one.id
        expect(json_response).to include(
          :id, :default_name, :country, :url
        )
      end
    end

    context "Non JSON" do
      it "should respond with json anyway" do
        get :index, format: :html
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end
end
