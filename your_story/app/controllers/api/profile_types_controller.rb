class Api::ProfileTypesController < ApplicationController
  def index
    render json: Participant.profile_types_json
  end
end
