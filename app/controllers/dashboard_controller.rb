class DashboardController < ApplicationController
  before_action :set_auth, only: [:index]

  def index
    if @auth.auth_header_valid?
      render json: { success: { message: "Welcome to dashboard, #{@auth.user.username}" } } 
    else 
      render json: { error: { message: "Sorry, you're not authenticated" } }
    end
  end

  private 
  def set_auth
    @auth = AuthService.new(auth_header: request.authorization)
  end
end
