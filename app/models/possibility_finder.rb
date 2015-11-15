class PossibilityFinder
  attr_reader :idea_type

  def initialize(idea_type)
    @idea_type = idea_type
  end

  def possibilities
    prepare_all
  end

  def raw_possibilities
    if @raw_possibilities
      @raw_possibilities
    else
      @raw_possibilities = {}
      services.each do |service|
        @raw_possibilities = @raw_possibilities.merge(service.raw_possibilities)
        @raw_possibilities.each_value { |content| content.downcase! }
      end
    end
  end

  private

  def services
    ServicesFinder.new(idea_type).services
  end

  def prepare_all
    raw_possibilities
    [WhiteList, BlackList, Creator].each do |worker|
      @raw_possibilities = worker.new(self).prepare
    end
    @raw_possibilities
  end
end
