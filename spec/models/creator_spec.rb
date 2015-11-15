require "rails_helper"

RSpec.describe Creator, type: :model do
  describe "#prepare" do
    it "returns a collection of possibility objects" do
      raw = { "http://twitter.com/trending" => ["asdf"],
        "http://producthunt.com/new" => ["test driven development",
          "internet of things", "asdf", "cool"] }
      finder = instance_double("PossibilityFinder", :raw_possibilities => raw)
      creator = Creator.new(finder)

      possibilities = creator.prepare

      expect(possibilities.last.title).to eq("cool")
      expect(possibilities.last.source).to eq("http://producthunt.com/new")
      expect(possibilities.first.title).to eq("asdf")
      expect(possibilities.first.source).to eq("http://twitter.com/trending")
      expect(possibilities.first).to be_kind_of(Possibility)
    end
  end
end
