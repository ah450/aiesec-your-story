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

      it "should have pagination" do
        get :index, format: :json, page: 1, page_size: 5
        json = json_response
        expect(json.states.length).to be <= 5
      end

      it "should have show" do
        get :show, format: :json, id: state_one.id
        expect(json_response).to include(
          :id, :default_name, :country, :url
        )
      end

      context 'search' do
        it "should support exact match" do
          get :index, format: :json, term: state_one.default_name
          expect(json_response.length).to eq 1
          received = State.new json_response.first
          expect(received.id).to eq state_one.id
        end

        it "Should support partial match" do
          get :index, format: :json, term: state_one.default_name[0..4]
          expect(json_response.length).to be >= 1
          expect(
          json_response.any? { |e|  e.id == state_one.id }).to be true
        end
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
