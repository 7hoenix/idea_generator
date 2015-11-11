require "rails_helper"

RSpec.describe PossibilityPresenter, type: :model do
  describe "#possibilities" do
    it "returns a listing of possibilities" do
      possibility1 = create(:possibility, title: "wonder")
      possibility2 = create(:possibility, title: "woman")
      possibilities = [possibility1, possibility2]
      presenter = PossibilityPresenter.new(possibilities)

      expect(presenter.possibilities.first.title).to eq(possibilities.first.title)
    end
  end
end
