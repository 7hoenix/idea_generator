require "rails_helper"

RSpec.describe BlackList, type: :model do
  describe "#prepare" do
    it "parses the raw data to remove fluff words" do
      raw = { "http://twitter.com/trending" => ["asdf it asdf and asdf the asdf asdf asdf"],
      "http://producthunt.com/new" => ["test driven development", "internet of things", "and asdf the asdf asdf it cool"] }
      finder = instance_double("PossibilityFinder", :raw_possibilities => raw)
      black_list = BlackList.new(finder)

      parsed = black_list.prepare

      expected = { "http://twitter.com/trending" => ["asdf"],
        "http://producthunt.com/new" => ["test driven development",
          "internet of things", "asdf", "cool"] }
      expect(parsed).to eq(expected)
    end
  end
end
