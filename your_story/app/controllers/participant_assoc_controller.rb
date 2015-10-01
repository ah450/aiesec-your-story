class ParticipantAssocController < ApplicationController
  before_filter :parent_set
  
  def index
    if params[:participant_id] == 'all'
      # All records
      super
    else
      resources = resource_class.where(query_params.merge({participant: @parent}))
                                .page(page_params[:page])
                                .per(page_params[:page_size])
      instance_variable_set(plural_resource_variable, resources)
      render_array
    end
  end

  private
    def get_participant
      @participant = Participant.find(params[:participant_id])
    end

    def parent_set
      @parent = get_participant unless params[:participant_id] == 'all'
    end
end