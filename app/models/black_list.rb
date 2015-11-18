class BlackList < Global::BlackList
  attr_reader :finder

  def initialize(finder)
    @finder = finder
  end

  def black_list
    @black_list ||= super + finder.black_listed
  end

  def prepare
    post_black_list = {}
    finder.raw_possibilities.each do |source, content|
      temp = content.pop.split(" ")
      content = content + (temp.uniq - black_list)
      post_black_list[source] = remove_punctuation(content)
    end
    post_black_list
  end

  private

  def remove_punctuation(content)
    content.map { |phrase| phrase.gsub(/[^a-zA-Z ]*/, "") }
  end
end
