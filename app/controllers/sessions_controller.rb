class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token # Skip CSRF check for API requests (if necessary)

  def authenticate
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      token = user.generate_jwt # Assuming you’ve implemented the `generate_jwt` method in your User model
      render json: { success: true, token: token }, status: :ok
    else
      render json: { success: false, message: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
