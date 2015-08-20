class Api::StatesController < ApplicationController
  private
    def json_builder(subject)
      subject.json_builder.merge({
          url: api_states_path(subject)
        })
    end
end
