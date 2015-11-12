require "rails_helper"

RSpec.describe ServicesFinder do
  describe "#services" do
    it "returns a listing of service objects" do
      finder = ServicesFinder.new("business")

      collection = finder.services

      expect(collection.count).to eq(2)
      expect(collection.first.class).to eq(Services::TwitterService)
    end
  end
end
