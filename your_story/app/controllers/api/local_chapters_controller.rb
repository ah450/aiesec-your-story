class Api::LocalChaptersController < ApplicationController

  private
    def json_builder(subject)
      subject.json_builder.merge({
        url: api_local_chapters_path(subject)
        })
    end
end
