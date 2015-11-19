require "rails_helper"

RSpec.describe Api::V1::IdeasController, type: :controller do

  include Controllers::JsonHelpers
  describe "GET index" do
    it "returns a listing of ideas for that user" do

      get :index, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "creates a new idea for that user" do
    end
  end
end
