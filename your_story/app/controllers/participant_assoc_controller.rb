class ParticpantAssocController < ApplicationController
  before_filter :parent_set, only: [:show, :destory, :update]
  
  private
    def participant
      @participant = Participant.find(params[:participant_id])
    end

    def parent_set
      @parent = participant
    end
end