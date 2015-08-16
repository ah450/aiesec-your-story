class Avatar < ActiveRecord::Base
  validates :filename, :mime_type, :data, presence: true

  def self.gen_name
    (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
