class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] ||= user.id
    redirect_to profile_path
  end

  def destroy
    session.clear
    redirect_to dashboard_path
  end
end
