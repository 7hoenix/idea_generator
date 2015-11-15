class BlackList
  attr_reader :finder,
    :black_list

  def initialize(finder)
    @finder = finder
    @black_list = ["it", "and", "the"]
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
