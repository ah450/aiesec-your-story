class StateName < ActiveRecord::Base
  belongs_to :state
  validates_presence_of :name
  after_commit :reindex_state


  def reindex_state
    state.reindex_async
  end
end
