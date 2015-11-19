require "rails_helper"

RSpec.describe Api::V1::IdeasController, type: :controller, vcr: true do

  include Controllers::JsonHelpers
  describe "GET index" do
    it "returns a listing of ideas for that user" do
      alpha = create(:possibility)
      beta = create(:possibility)
      alpha_two = create(:possibility)
      beta_two = create(:possibility)
      user = create(:user)
      create(:idea, user_id: user.id, possibility_alpha_id: alpha.id,
        possibility_beta_id: beta.id)
      create(:idea, user_id: user.id, possibility_alpha_id: alpha_two.id,
        possibility_beta_id: beta_two.id)
      session[:user_id] = user.id

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(2)
    end
  end

  describe "POST create" do
    it "gives back a 401 if not logged in" do
      alpha = create(:possibility)
      beta = create(:possibility)
      idea = {possibility_alpha_id: alpha.id, possibility_beta_id: beta.id}

      post :create, idea: idea, format: :json

      expect(response).to have_http_status(:unauthorized)
    end

    it "creates an idea if logged in" do
      user = create(:user)
      session[:user_id] = user.id
      alpha = create(:possibility)
      beta = create(:possibility)
      idea = {possibility_alpha_id: alpha.id, possibility_beta_id: beta.id}
      composite = alpha.title + " " + beta.title

      post :create, idea: idea, format: :json

      expect(response).to have_http_status(:ok)
      expect(Idea.last.composite).to eq(composite)
    end
  end

  describe "DELETE destroy" do
    it "deletes the selected idea for a user" do
      user = create(:user)
      alpha = create(:possibility)
      beta = create(:possibility)
      idea = create(:idea, user_id: user.id,
        possibility_alpha_id: alpha.id, possibility_beta_id: beta.id)
      session[:user_id] = user.id

      delete :destroy, :id => idea, format: :json

      expect(response).to have_http_status(:ok)
      expect(Idea.last).to_not eq(idea)
    end
  end

  describe "GET current" do
    it "returns the current possibilities for an idea" do
      user = create(:user)
      alpha = create(:possibility)
      beta = create(:possibility)
      session[:user_id] = user.id
      session[:idea_params] = {possibility_alpha_id: alpha.id, possibility_beta_id: beta.id}

      get :current, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.last["title"]).to eq(beta.title)
    end
  end
end
