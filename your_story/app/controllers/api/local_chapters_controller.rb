class Api::LocalChaptersController < ApplicationController
  def index
    if params[:term].blank?
      super
    else
      render json: LocalChapter.search(params[:term])
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
