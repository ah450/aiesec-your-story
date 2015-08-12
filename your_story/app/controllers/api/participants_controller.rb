class Api::ParticipantsController < ApplicationController

  PROFILE_TYPES = [MemberProfile, TalentProfile, CitizenProfile]
  # POST /api/{plural_resource_name}
  def create  
    begin
      profile_class = PROFILE_TYPES.detect {|p| participant_params[:type].classify.constantize == p}
    ensure
      unless profile_class
        render json: {message: "bad_request"}, status: :bad_request
      end
    end
    profile_params = participant_params.delete :profile_attributes
    participant = Participant.new participant_params.except(:profile_attributes).reject{|e| ["type", :type].include? e}
    participant.profile = profile_class.new profile_params.reject{ |e| [:local_chapter, "local_chapter"].include? e  }
    participant.profile.participant = participant
    participant.profile.local_chapter = LocalChapter.find(profile_params.local_chapter)
    if participant.save
      render json: participant, status: :created
    else
      render json: participant.errors, status: :unprocessable_entity
    end
  end

  private

    def participant_params
      attributes = model_attributes
      member_attrs = MemberProfile.attribute_names.reject{|e| [:participant].include? e} | [:local_chapter]
      talent_attrs = TalentProfile.attribute_names.reject{|e| [:participant].include? e}
      citizen_attrs = CitizenProfile.attribute_names.reject{|e| [:participant].include? e}
      profile_attributes = [profile_attributes: member_attrs | talent_attrs | citizen_attrs]
      attributes.concat(profile_attributes)
      params.require(:participant).permit(attributes | [:type])
    end
end
