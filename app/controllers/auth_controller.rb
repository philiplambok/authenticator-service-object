class AuthController < ApplicationController
  before_action :set_auth, only: [:create]

  def create
    if @auth.token
      render json: { jwt: @auth.token }
    else
      render json: { error: {message: "Sorry, the credential is invalid"} }
    end
  end

  private 
  def auth_params 
    params.require(:auth).permit(:username, :password)
  end

  def set_auth
    @auth = AuthService.new(auth_params)
  end
end