class Api::StatesController < ApplicationController
  def index
    if params[:term].blank?
      super
    else
      # Search all the things you crazy bastard!
      response = State.search params[:term]
      render json: response.records.to_a
    end
  end
end
