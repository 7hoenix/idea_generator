require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#white_listed" do
    it "returns possibilities on the white list" do
      user = create(:user)
      alpha = create(:possibility)
      beta = create(:possibility)
      create(:white_list, possibility_id: alpha.id, user_id: user.id)
      create(:white_list, possibility_id: beta.id, user_id: user.id)

      possibilities = user.white_listed

      expect(possibilities.last.list_type).to eq("white")
    end
  end
end
