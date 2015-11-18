class Creator
  attr_reader :finder

  def initialize(finder)
    @finder = finder
  end

  def prepare
    possibles = []
    finder.raw_possibilities.each do |source, content|
      content.each do |phrase|
        possibles << Possibility.find_or_create_by(source: source, title: phrase)
      end
    end
    possibles
  end
end
