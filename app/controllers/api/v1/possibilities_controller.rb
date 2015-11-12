class Api::V1::PossibilitiesController < ApplicationController
  respond_to :json

  def index
    respond_with PossibilityFinder.new(params[:idea_type]).possibilities
  end
end
