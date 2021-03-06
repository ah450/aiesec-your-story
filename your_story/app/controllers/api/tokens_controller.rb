class Api::TokensController < ApplicationController
  skip_filter :authorize, :authenticate, only: [:create]
  
  def create
    user = User.find_by_email(token_params[:email])
    raise AuthenticationError unless user.authenticate(token_params[:password])
    render json: {token: user.token(params[:expiration])}
  end

  private
    def token_params
      params.require(:token).permit([:email, :password, :expiration])
    end
end
