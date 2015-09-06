class Api::StatesController < ApplicationController

  def index
    if params[:query]
      query = params[:query].downcase
      @states = State.where('lower(name) LIKE ?', "#{query}%")
      render json: @states.map { |state| json_builder(state) }
    else
      super
    end
  end

  private
    def json_builder(subject)
      subject.json_builder.merge({
          url: api_state_path(subject)
        })
    end
end
