class Story < ActiveRecord::Base
  belongs_to :participant
  belongs_to :state
  validates_presence_of :title, :highlight, :participant, :state, :date
  paginates_per 10000000

  def json_builder
    as_json.merge({
      state: state.json_builder
      })
  end

end
