# lib/json_web_token.rb

require 'jwt'

module JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt_secret || ENV['JWT_SECRET']

  # Encode a payload into a JWT
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i # Set expiration timestamp
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decode and verify a JWT
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    decoded[0] # Return the payload (first element of the decoded array)
  rescue JWT::ExpiredSignature
    raise 'Token has expired'
  rescue JWT::DecodeError => e
    raise "Invalid token: #{e.message}"
  end
end
