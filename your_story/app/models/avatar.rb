class Avatar < ActiveRecord::Base
  belongs_to :participant
  validates :filename, :mime_type, :data, :participant, presence: true

  def self.gen_name
    (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def json_builder
    {
      filename: filename,
      mime_type: mime_type
    }
  end
end
