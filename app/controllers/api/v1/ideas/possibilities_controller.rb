class Api::V1::Ideas::PossibilitiesController < ApplicationController
  respond_to :json

  def index
    respond_with Possibility.for_an_idea(params[:idea_id])
  end
end
