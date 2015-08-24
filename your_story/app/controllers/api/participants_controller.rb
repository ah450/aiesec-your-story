class Api::ParticipantsController < ApplicationController
  
  PROFILE_TYPES = [MemberProfile, TalentProfile, CitizenProfile]

  # POST /api/{plural_resource_name}
  def create  
    begin
      # Detect clas based on type param
      profile_klass = PROFILE_TYPES.detect {|p| participant_params[:type].to_s.classify.constantize == p}
    ensure
      unless profile_klass
        render json: {message: "Could not detect profile class"}, status: :bad_request
      end
    end
    # Extract profile specific attributes
    profile_params = participant_params.delete :profile_attributes 
    # Initialize participant, minus profile_attributes
    @participant = Participant.new participant_params.except(
      :profile_attributes).reject {|e| ["type", "local_chapter"].include? e}
    # Initialize profile
    @participant.profile = profile_klass.new profile_params
    @participant.profile.participant = @participant
    # Set local chapter
    @participant.local_chapter = LocalChapter.find(participant_params[:local_chapter])
    if @participant.save
      render_single
    else
      render json: @participant.errors, status: :unprocessable_entity
    end
  end

  private

    def participant_params
      attributes = model_attributes | [:local_chapter]
      member_attrs = MemberProfile.attribute_names.reject{|e| [:participant].include? e}
      talent_attrs = TalentProfile.attribute_names.reject{|e| [:participant].include? e}
      citizen_attrs = CitizenProfile.attribute_names.reject{|e| [:participant].include? e}
      profile_attributes = [profile_attributes: member_attrs | talent_attrs | citizen_attrs]
      attributes.concat(profile_attributes)
      params.require(:participant).permit(attributes | [:type])
    end

    def json_builder(subject)
      json = subject.json_builder.merge({
        url: api_participant_path(subject),
        stories_url: api_participant_stories_path(subject)
        })
      json.merge({
        avatars: json[:avatars].map { |e| e.merge({
          url: api_participant_avatar_path(subject, e)
          })}
        })
    end
end
