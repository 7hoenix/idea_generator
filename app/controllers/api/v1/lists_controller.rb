class Api::V1::ListsController < ApplicationController
  def create
    ListCreator.new(current_user, params).list
    render json: true
  end
end
