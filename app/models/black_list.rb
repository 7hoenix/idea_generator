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
      post_black_list[source] = content
    end
    post_black_list
  end
end
