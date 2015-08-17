FactoryGirl.define do
  factory :local_chapter do
    name Faker::Address.city
    after(:create) {|lc| LocalChapter.reindex}
  end
end
