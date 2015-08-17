class Api::StatesController < ApplicationController
  def index
    if params[:term].blank?
      super
    else
      render json: State.custom_search(params[:term])
    end
  end

  private
    def json_builder(subject)
      {
        default_name: subject.default_name,
        id: subject.id,
        country: subject.country,
        url: api_states_path(subject)
      }
    end
end
