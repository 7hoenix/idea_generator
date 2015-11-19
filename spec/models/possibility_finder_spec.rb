require "rails_helper"

RSpec.describe PossibilityFinder, type: :model, vcr: true do
  describe "#possibilities" do
    it "returns a listing of possibilities" do
      user = create(:user)
      create(:possibility)
      create(:possibility)
      create(:black_list, user_id: user.id)
      create(:white_list, user_id: user.id)
      Rails.cache.clear

      finder = PossibilityFinder.new("business", user)

      expect(finder.possibilities).to eq(384)
    end
  end
end
