class User < ActiveRecord::Base
  has_secure_password


  # Generates an expiring JWT
  # exp unit is hours
  # Default is one day
  def token(expiration=nil)
    expiration ||= 24
    payload = {
      data: {
        id: id,
        discriminator: password_digest
      },
      exp: Time.now.to_i + (expiration * 60 * 60)
    }
    JWT.encode payload, User.hmac_key, 'HS512'
  end

  # Retrieve user based on token
  # Raises JWT::VerificationError if key missmatch or signature corrupted
  # Raises JWT::ExpiredSignature
  # Both subclasses of JWT::DecodeError
  # Raises ActiveRecord::RecordNotFound if user no longer exists
  # Raises AuthenticationError if incorrect authentication data supplied
  # returns user
  def self.find_by_token(token)
    decoded = JWT.decode token, hmac_key, true, {leeway: 60}
    data = decoded.first["data"]
    user = find(data["id"])
    raise AuthenticationError unless Rack::Utils.secure_compare(
      user.password_digest, data["discriminator"])
    return user
  end

  private
    def self.hmac_key
      Rails.application.config.jwt_key
    end
end
