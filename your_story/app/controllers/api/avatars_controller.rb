class Api::AvatarsController < ParticipantAssocController
  
  def show
    send_data get_resource.data, type: get_resource.mime_type, disposition: 'inline'
  end

  def create
    filename = "#{Avatar.gen_name}#{Rack::Mime::MIME_TYPES.invert[resource_params.data.content_type]}"
    @avatar = Avatar.new(data: resource_params.data.read,
      filename: filename,
      mime_type: resource_params.data.content_type,
      participant: @parent
      )
    if @avatar.save
      render_single :created
    else
      render json: @avatar.errors, status: :unprocessable_entity
    end
  end

  private
    def avatar_params
      params.require(:avatar).permit [:data]
    end

    def json_builder(subject)
      subject.json_builder.merge({
        url: api_participant_avatar_path(subject.participant, subject)
        })
    end

end
