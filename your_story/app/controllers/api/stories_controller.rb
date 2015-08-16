class Api::StoriesController < ParticpantAssocController
  before_filter :parent_set

  def create
    @story = Story.new story_params
    @story.participant = @parent
    @story.state = State.find(story.state_id)
    if @story.save
      render_single, :created
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  private
    def story_params
      attributes = model_attributes
      params.require(:story).permit(attributes)
    end
    
    def json_builder(subject)
      json = subject.as_json include: {
        state: {
          only: [:default_name]
        }
      }
      json[:url] = api_participant_stories_path(subject.participant, subject)
      json[:participant_url] =  api_participant_path(subject.participant)
      json[:state_url] = api_states_path(subject.state)
      return json
    end
end
