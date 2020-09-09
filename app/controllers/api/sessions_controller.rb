class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      token, expiration_time = encode_token({user_id: user.id})
      render json: {user: user, token: token, expires_in: expiration_time}
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: user
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
