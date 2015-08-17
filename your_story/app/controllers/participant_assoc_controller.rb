class ParticipantAssocController < ApplicationController
  before_filter :parent_set
  
  private
    def get_participant
      @participant = Participant.find(params[:participant_id])
    end

    def parent_set
      @parent = get_participant
    end
end