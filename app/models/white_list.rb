class WhiteList < Global::WhiteList
  attr_reader :finder

  def initialize(finder)
    @finder = finder
  end

  def white_list
    @white_list ||= super + finder.white_listed
  end

  def prepare
    white_listed_possibilities = {}
    finder.raw_possibilities.each do |source, content|
      possibles = []
      white_list.each do |white_phrase|
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
