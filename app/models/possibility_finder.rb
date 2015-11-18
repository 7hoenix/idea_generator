class PossibilityFinder
  attr_reader :idea_type,
              :current_user

  def initialize(idea_type, current_user)
    @idea_type = idea_type
    @current_user = current_user if current_user
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

  def black_listed
    current_user.try!(:black_listed) || []
  end

  def white_listed
    current_user.try!(:white_listed) || []
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
    @raw_possibilities.shuffle
  end
end
