require 'rails_helper'

describe Api::LocalChaptersController do
  describe "index" do
    let(:local_chapter_one) {FactoryGirl.create(:local_chapter)}
    let(:local_chapter_two) {FactoryGirl.create(:local_chapter)}

    context "JSON" do
      it "should respond to index action" do
        get :index, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
        expect(response).to be_success
        expect(json_response.local_chapters).to be_an_instance_of Array
      end

      it "should have pagination" do
        get :index, format: :json, page: 1, page_size: 5
        json = json_response
        expect(json.local_chapters.length).to be <= 5
        expect(json_response).to include(
          :local_chapters, :page, :page_size, :total_pages
          )
      end

      it "should have show" do
        get :show, format: :json, id: local_chapter_one.id
        expect(json_response).to include(
          :id, :name, :url
        )
      end

      context 'search' do
        it "should support exact match" do
          get :index, format: :json, term: local_chapter_one.name
          expect(json_response.length).to eq 1
          received = LocalChapter.new json_response.first
          expect(received.id).to eq local_chapter_one.id
        end

        it "Should support partial match" do
          get :index, format: :json, term: local_chapter_one.name[0..6]
          expect(json_response.length).to be >= 1
          expect(
          json_response.any? { |e|  e.id == local_chapter_one.id }).to be true
        end
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
