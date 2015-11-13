class PossibilityFinder
  attr_reader :idea_type

  def initialize(idea_type)
    @idea_type = idea_type
    @raw_possibilities = {}
  end

  def possibilities
    # prepare(raw_possibilities)
    raw_possibilities
    binding.pry

    # possibilities = []
    # possibilities << Possibility.create(title: "wonder", source: "twitter")
    # possibilities << Possibility.create(title: "woman", source: "producthunt")
    # possibilities << Possibility.create(title: "water", source: "twitter")
    # possibilities << Possibility.create(title: "people carrying sticks", source: "producthunt")
    # possibilities << Possibility.create(title: "inner-city", source: "producthunt")
    # possibilities << Possibility.create(title: "yolo", source: "twitter")
    # possibilities << Possibility.create(title: "Cards Against Humanity", source: "producthunt")
    # possibilities
  end

  private
  attr_accessor :raw_possibilities

  def raw_possibilities
    services.each do |service|
      @raw_possibilities = @raw_possibilities.merge(service.raw_possibilities)
    end
    @raw_possibilities
  end

  def services
    ServicesFinder.new(idea_type).services
  end

  def prepare(raw)
    binding.pry
    [Protector.new, Cleaner.new, Creator.new].each do |worker|
      worker.send(:prepare, self)
    end
  end
end
