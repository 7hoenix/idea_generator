class PossibilityFinder
  attr_reader :possibilities

  def initialize(idea_type)
    @possibilities = []
    possibilities << Possibility.create(title: "wonder", source: "twitter")
    possibilities << Possibility.create(title: "woman", source: "producthunt")
    possibilities << Possibility.create(title: "water", source: "twitter")
    possibilities << Possibility.create(title: "people carrying sticks", source: "producthunt")
    possibilities << Possibility.create(title: "inner-city", source: "producthunt")
    possibilities << Possibility.create(title: "yolo", source: "twitter")
    possibilities << Possibility.create(title: "Cards Against Humanity", source: "producthunt")
  end
end
