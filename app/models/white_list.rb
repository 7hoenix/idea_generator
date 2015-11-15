class WhiteList
  attr_reader :finder,
    :white_listed_phrases

  def initialize(finder)
    @finder = finder
    @white_listed_phrases = ["test driven development", "internet of things", "ruby
      on rails", "black friday"]
  end

  def prepare
    raw = finder.raw_possibilities
    white_listed_possibilities = {}
    raw.each do |source, content|
      possibles = []
      white_listed_phrases.each do |white_phrase|
        if content.include?(white_phrase)
          content.gsub!(white_phrase, "")
          possibles << white_phrase
        end
      end
      possibles << content
      white_listed_possibilities[source] = possibles
    end
    white_listed_possibilities
  end
end
