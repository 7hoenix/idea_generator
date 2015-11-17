require "rails_helper"

RSpec.describe Services::BusinessUSAService, vcr: true do
  describe "#raw_possibilities" do
    it "returns a list of raw possibilites" do
      business_usa = Services::BusinessUSAService.new

      raw_possibilities = business_usa.raw_possibilities

      expect(raw_possibilities.keys.first).to eq("http://www.nist.gov/mep/find-your-local-center.cfm")
      expect(raw_possibilities.values.first).to eq("Expanding For J&#039;s Sales Network Through Exporting")
    end
  end
end
