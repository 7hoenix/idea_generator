class Api::V1::IdeasController < ApplicationController
  respond_to :json

  def index
    respond_with Idea.where(user_id: current_user.id) if current_user
  end

  def create
    binding.pry
  end
end
