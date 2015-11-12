require "rails_helper"

RSpec.describe Services::ProductHuntService do
  describe "#raw_possibilities" do
    it "returns a collection of sources pointing at text" do
      product_hunt = Services::ProductHuntService.new

      collection = product_hunt.raw_possibilities

      expect(collection.keys.first).to eq("http://producthunt.com/new")
      expect(collection.values.first).to eq("asdf asdf asdf")
    end
  end
end
