class Api::LocalChaptersController < ApplicationController
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
        id: subject.id,
        name: subject.name,
        url: api_local_chapters_path(subject)
      }
    end
end
