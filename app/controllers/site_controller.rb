class SiteController < ApplicationController
  def landing
  end

  def dashboard
    possibility1 = Possibility.create(title: "wonder", source: "twitter")
    possibility2 = Possibility.create(title: "woman", source: "producthunt")
    @possibility_presenter = PossibilityPresenter.new([possibility1,
      possibility2])
  end

  def profile
    @ideas = [["water chestnuts"], ["Christmas present"], ["inner city water"]]
  end
end
