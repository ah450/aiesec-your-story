class Story < ActiveRecord::Base
  belongs_to :participant
  belongs_to :state
  has_one :issue
  has_one :company
  validates_presence_of :title, :highlight, :participant, :state, :date
  accepts_nested_attributes_for :issue
  accepts_nested_attributes_for :company
  paginates_per 10000000

  def json_builder
    json = as_json(
      include: [:issue, :company]
      )
    json.merge({
      state: state.json_builder
      })
  end

end
