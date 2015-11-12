require "rails_helper"

RSpec.describe Api::V1::PossibilitiesController, type: :controller do

  include Controllers::JsonHelpers
  describe "GET index" do
    it "returns a listing of possibilities" do
      get :index, idea_type: "business", format: :json
      expect(response).to have_http_status(:ok)
      expect(json.first["title"]).to eq("wonder")
    end
  end
end
