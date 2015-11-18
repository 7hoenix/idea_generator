class BlackList < Global::BlackList
  attr_reader :finder

  def initialize(finder)
    @finder = finder
  end

  def black_list
    @black_list ||= super + finder.black_listed
  end

  def prepare
    raw = finder.raw_possibilities
    post_black_list = {}
    raw.each do |source, content|
      temp = content.pop.split(" ")
      content = content + (temp.uniq - black_list)
      post_black_list[source] = content
    end
    post_black_list
  end
end
