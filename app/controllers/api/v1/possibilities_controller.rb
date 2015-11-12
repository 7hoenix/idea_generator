class Api::V1::PossibilitiesController < ApplicationController
  respond_to :json

  def index
    possibility1 = Possibility.create(title: "wonder", source: "twitter")
    possibility2 = Possibility.create(title: "woman", source: "producthunt")
    possibility3 = Possibility.create(title: "water", source: "twitter")
    possibility4 = Possibility.create(title: "people carrying sticks", source: "producthunt")
    possibility_presenter = PossibilityPresenter.new([possibility1,
      possibility2, possibility3, possibility4])
    respond_with possibility_presenter.possibilities
  end
end
