class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] ||= user.id
    if session[:idea_params]
      redirect_to confirm_path
    else
      redirect_to profile_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
