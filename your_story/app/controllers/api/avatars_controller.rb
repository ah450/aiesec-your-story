class Api::AvatarsController < ParticpantAssocController
  
  def show
    send_data get_resorce.data, type: get_resource.mime_type, disposition: 'inline'
  end

  def create
    filename = "#{Avatar.gen_name}#{Rack::Mime::MIME_TYPES.invert[resource_params.data.content_type]}"
    @avatar = Avatar.new(data: resource_params.data,
      filename: filename,
      mime_type: resource_params.data.content_type,
      participant: @parent
      )
    if @avatar.save
      render_single, :created
    else
      render json: @avatar.errors, status: :unprocessable_entity
  end

  private
    def avatar_params
      param.require(:avatar).permit[:data]
    end

    def json_builder(subject)
      {
        filename: @avatar.filename,
        mime_type: @avatar.mime_type
      }
    end

end
