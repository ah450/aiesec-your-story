class ApplicationController < ActionController::Base
  respond_to :json
  before_action :set_resource, only: [:destroy, :show, :update]
  before_action :authenticate, :authorize, only: [:destroy, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :argument_error
  rescue_from ActionController::ParameterMissing, with: :argument_error
  rescue_from AuthenticationError, with: :authentication_error
  rescue_from JWT::ExpiredSignature, with: :expired_signature
  rescue_from JWT::VerificationError, with: :verification_error


  # POST /api/{plural_resource_name}
  def create
    set_resource(resource_class.new(resource_params))
    if get_resource.save
      render_single :created
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  # GET /api/{plural_resource_variable}
  def index
    resources = resource_class.where(query_params)
                              .page(page_params[:page])
                              .per(page_params[:page_size])
    instance_variable_set(plural_resource_variable, resources)
    render_array
  end

  # DELETE /api/{plural_resource_name}/1
  def destroy
    get_resource.destroy
    head :no_content
  end

  # GET /api/{plural_resource_name}/1
  def show
   render_single
  end

  # PATCH/PUT /api/{plural_resource_name}/1
  def update
    if get_resource.update(resource_params)
      render_single
    else
      render json: get_resource.errors, status: :unprocessable_entity
    end
  end

  private

    # Returns the resource from the created instance variable
    # @return [Object]
    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def model_attributes
      resource_class.attribute_names.map{|s| s.to_sym}.reject{|e| [:created_at, :updated_at].include? e}
    end

    # Returns the allowed parameters for pagination
    # @return [Hash]
    def page_params
      params.permit(:page, :page_size)
    end

    # Returns the allowed parameters for searching
    # Override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    def render_array
      resources = instance_variable_get(plural_resource_variable)
       json =  {
        page: resources.current_page,
        total_pages:  resources.total_pages,
        page_size: resources.size
      }
      json[resource_name.pluralize] = resources.map { |s| json_builder(s) }
      render json: json
    end

    def render_single(status=:ok)
      json = {}
      json[resource_name] = json_builder(get_resource)
      render json: json , status: status
    end

    # The resource class based on the controller
    # @return [Class]
    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    # The singular name for the resource class based on the controller
    # @return [String]
    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    # Only allow a trusted parameter "white list" through.
    # If a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource(resource = nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end

    # Rescue from ActiveRecord::RecordNotFound
    def record_not_found
      render json: {message: error_messages[:record_not_found]}, status: :not_found
    end

    # Rescue from ArgumentError
    def argument_error
      render json: {message: error_messages[:argument_error]}, status: :unprocessable_entity
    end

    # Rescue from AuthenticationError
    def authentication_error
      prepare_unauthorized_response
      render json: {message: error_messages[:authentication_error]}
    end

    # Rescue from JWT::ExpiredSignature
    def expired_signature
      prepare_unauthorized_response
      render json: {message: error_messages[:expired_token]}
    end

    # Rescue from JWT::VerificationError
    def verification_error
      prepare_unauthorized_response
      render json: {message: error_messages[:token_verification]}
    end

    # Attempts to set current user
    def authenticate
      authenticate_with_http_token("ImpactAppUser") do |token, options|
        @current_user = User.find_by_token token
      end
    end

    # To be overriden by subclasses
    # To check for roles
    def user_authorized
      true
    end

    def authorize
      render json: {message: error_messages[:forbidden]}, status: :forbidden unless user_authorized
    end

    # Set Header and response
    def prepare_unauthorized_response
      response['WWW-Authenticate'] = 'Token realm="ImpactAppUser"'
      response.status = :unauthorized
    end

    def error_messages
      Rails.application.config.configuration[:error_messages]
    end

    def plural_resource_variable
      "@#{resource_name.pluralize}"
    end
end
