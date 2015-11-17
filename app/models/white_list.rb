class WhiteList < Global::WhiteList
  attr_reader :finder

  def initialize(finder)
    @finder = finder
  end

  def white_list
    @white_list ||= super + ["sugary"]
  end

  def prepare
    raw = finder.raw_possibilities
    white_listed_possibilities = {}
    raw.each do |source, content|
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
