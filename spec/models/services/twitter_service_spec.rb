require "rails_helper"

RSpec.describe Services::TwitterService do
  describe "#raw_possibilities" do
    it "returns a list of raw possibilites" do
      twitter = Services::TwitterService.new

      raw_possibilities = twitter.raw_possibilities

      expect(raw_possibilities.keys.first).to eq("http://twitter.com/trending")
      expect(raw_possibilities.values.first).to eq("asdf asdf asdf asdf asdf asdf")
    end
  end
end
