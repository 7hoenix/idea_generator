require "rails_helper"

RSpec.describe PossibilityFinder, type: :model do
  describe "#possibilities" do
    xit "returns a listing of possibilities" do
      possibility1 = create(:possibility, title: "wonder")
      possibility2 = create(:possibility, title: "woman")
      possibilities = [possibility1, possibility2]

      finder = PossibilityFinder.new("business")

      expect(finder.possibilities.first.title).to eq(possibilities.first.title)
    end
  end
end
