class Api::V1::IdeasController < ApplicationController
  respond_to :json

  def index
    respond_with Idea.where(user_id: current_user.id) if current_user
  end

  def create
    if current_user
      alpha = params[:idea][:possibility_alpha_id]
      beta = params[:idea][:possibility_beta_id]
      Idea.find_or_create_by(user_id: current_user.id, possibility_alpha_id:
        alpha, possibility_beta_id: beta)
      render json: true
    else
      session[:idea_params] = params[:idea]
      render json: { error: "not logged in"}, status: 401
    end
  end

  def current
    possibility_ids = session.fetch(:idea_params)
    possibilities = possibility_ids.map { |_, possibility_id| Possibility.find(possibility_id) }
    session.delete(:idea_params)
    respond_with possibilities
  end
end
