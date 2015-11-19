require 'rails_helper'

RSpec.describe Possibility, type: :model do
  describe ".for_an_idea" do
    it "returns possibilities for an idea" do
      user = create(:user)
      alpha = create(:possibility)
      beta = create(:possibility)
      idea = create(:idea, user_id: user.id, possibility_alpha_id: alpha.id,
        possibility_beta_id: beta.id)

      possibilities = Possibility.for_an_idea(idea.id)

      expect(possibilities.last).to eq(beta)
    end
  end
end
