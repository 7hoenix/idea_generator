require "rails_helper"

RSpec.describe PossibilityFinder, type: :model, vcr: true do
  describe "#possibilities" do
    it "returns a listing of possibilities" do
      user = create(:user)
      create(:black_list, user_id: user.id)
      create(:white_list, user_id: user.id)
      Rails.cache.clear

      post_white_list = { "http://twitter.com/trending" => ["justin s coffee", "asdf  asdf asdf asdf asdf asdf"],
      "http://producthunt.com/new" => ["test driven development", "internet of things", "asdf  asdf  asdf"] }
      WhiteList.any_instance.stub(:prepare).and_return post_white_list

      finder = PossibilityFinder.new("business", user)

      expect(finder.possibilities.count).to eq(5)
    end
  end
end
