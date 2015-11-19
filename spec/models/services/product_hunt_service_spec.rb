require "rails_helper"

RSpec.describe Services::ProductHuntService, vcr: true do
  describe "#raw_possibilities" do
    it "returns a collection of sources pointing at text" do
      product_hunt = Services::ProductHuntService.new

      collection = product_hunt.raw_possibilities

      expect(collection.keys.first).to eq("https://www.producthunt.com/tech/ucella-2")
      expect(collection.values.first).to eq("The smartest package & delivery mailbox")
    end
  end
end
