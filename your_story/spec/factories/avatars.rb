FactoryGirl.define do
  factory :avatar do
    data { File.read(File.join(Rails.root, 'spec', 'fixtures', 'lorem.jpg'), encoding: 'binary') }
    mime_type "image/jpeg"
    filename Avatar.gen_name
    participant {FactoryGirl.create(:participant)}
  end

end
