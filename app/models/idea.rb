class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :possibility

  def composite
    possibilities.map(&:title).join(" ")
  end

  def possibilities
    [Possibility.find(possibility_alpha_id), Possibility.find(possibility_beta_id)]
  end

  def as_json(opts = {})
    super.merge({possibilities: possibilities, composite: composite})
  end
end
