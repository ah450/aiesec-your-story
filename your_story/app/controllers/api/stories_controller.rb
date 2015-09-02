class Api::StoriesController < ParticipantAssocController
  before_filter :parent_set

  def create
    @story = Story.new story_params
    @story.participant = @parent
    @story.state = State.find(@story.state_id)
    if @story.save
      render_single :created
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  private
    def story_params
      attributes = model_attributes
      issueAttrs = [issue_attributes: [:name]]
      companyAttrs = [company_attributes: [:name]]
      nestedAttrs = issueAttrs | companyAttrs
      params.require(:story).permit(attributes | nestedAttrs)
    end
    
    def json_builder(subject)
      subject.json_builder.merge({
        url: api_participant_stories_path(subject.participant, subject),
        participant_url: api_participant_path(subject.participant),
        state_url: api_states_path(subject.state)
        })
    end
end
