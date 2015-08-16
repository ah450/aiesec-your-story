class Api::StatesController < ApplicationController
  def index
    if params[:term].blank?
      super
    else
      # Search all the things you crazy bastard!
      
    end
  end

  private
    def json_builder(subject)
      {
        default_name: subject.default_name,
        id: subject.id,
        url: api_states_path(subject)
      }
    end
end
