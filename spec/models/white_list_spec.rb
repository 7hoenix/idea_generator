require "rails_helper"

RSpec.describe WhiteList, type: :model do
  describe "#prepare" do
    it "parses raw data and trades out protected words for empty strings." do
      raw = { "http://twitter.com/trending" => "asdf justin s coffee asdf asdf asdf asdf asdf",
      "http://producthunt.com/new" => "asdf test driven development asdf internet of things asdf" }
      finder = instance_double("PossibilityFinder", :raw_possibilities => raw,
        :white_listed => ["justin s coffee"])
      white_list = WhiteList.new(finder)

      parsed = white_list.prepare

      expected = { "http://twitter.com/trending" => ["justin s coffee", "asdf  asdf asdf asdf asdf asdf"],
      "http://producthunt.com/new" => ["test driven development", "internet of things", "asdf  asdf  asdf"] }
      expect(parsed).to eq(expected)
    end
  end
end
