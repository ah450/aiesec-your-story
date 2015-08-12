class Api::StoriesController < ApplicationController
  before_filter :parent_set

  def create
    story = Story.new story_params
    story.participant = @parent
    story.state = State.find(story.state_id)
    if story.save
      render json: story, status: :created
    else
      render json: story.errors, status: :unprocessable_entity
    end
  end

  private
    def story_params
      attributes = model_attributes
      params.require(:story).permit(attributes)
    end

    def participant
      Participant.find(params[:participant_id])
    end

    def parent_set
      @parent = participant
    end
end
