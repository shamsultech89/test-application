class ApplicationController < ActionController::Base
  HMAC_SECRET = 'my$ecretK3y'.freeze
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:name, profile_attributes: %i(address street city state country zipcode)]
    )
  end

  private

  def encode_token(payload)
    expiration_time = 36000
    exp_payload = payload#.merge(exp: expiration_time)

    token = JWT.encode exp_payload, HMAC_SECRET, 'HS256'
    [token, expiration_time]
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode auth_header, HMAC_SECRET, true, { algorithm: 'HS256' }
      rescue JWT::ExpiredSignature
        # Handle expired token, e.g. logout user or deny access
        nil
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
