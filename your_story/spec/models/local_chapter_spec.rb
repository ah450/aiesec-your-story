require 'rails_helper'

describe LocalChapter do
  let(:factory) {FactoryGirl.create(:local_chapter)}
  it "has a valid factory" do
    expect(factory).to be_valid
  end
  context "when its name is nil" do
    let(:chapter) {FactoryGirl.build(:local_chapter, name: nil)}
    it 'is not valid' do
      expect(chapter).to_not be_valid
    end
  end
end
