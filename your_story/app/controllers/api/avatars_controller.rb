class Api::AvatarsController < ParticipantAssocController
  
  def show
    send_data get_resource.data, type: get_resource.mime_type, disposition: 'inline'
  end

  def create
    @avatars = []
    begin
      Avatar.transaction do

        resource_params.files.each do |file|
          # Get extension from mime type
          filename = "#{Avatar.gen_name}#{Rack::Mime::MIME_TYPES.invert[file.content_type]}"
          @avatars.push Avatar.create(data: file.read, filename: filename,
            mime_type: file.content_type, participant: @parent)
        end
      end
    rescue
      render json: @avatars.each_with_index.map { |e, i| {resource_params.files[i].original_filename => e.errors} },
        status: :unprocessable_entity
    else
      render json: @avatars.map { |e| json_builder(e) }, status: :created
    end
  end

  private
    def avatar_params
      params.require(:avatar).permit(:files => [])
    end

    def json_builder(subject)
      subject.json_builder.merge({
        url: api_participant_avatar_path(subject.participant, subject)
        })
    end

end
