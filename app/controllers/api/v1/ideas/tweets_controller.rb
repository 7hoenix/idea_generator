class Api::V1::Ideas::TweetsController < ApplicationController
  def create
    current_user.post(params[:idea_id]) if current_user
    render json: true
  end
end
