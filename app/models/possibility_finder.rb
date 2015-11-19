class PossibilityFinder
  attr_reader :idea_type,
              :current_user
  attr_accessor :raw_possibilities

  def initialize(idea_type, current_user)
    @idea_type = idea_type
    @current_user = current_user if current_user
    @raw_possibilities ||= get_raw_content
  end

  def possibilities
    prepare_all
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

  def get_raw_content
    Rails.cache.fetch("raw_content", expires_in: 24.hours) do
      raw_content = {}
      services.each do |service|
        raw_content = raw_content.merge(service.raw_possibilities)
        raw_content.each_value { |content| content.downcase! }
      end
      raw_content
    end
  end

  def prepare_all
    Rails.cache.fetch("prepared_content", expires_in: 24.hours) do
      [WhiteList, BlackList, Creator].each do |worker|
        @raw_possibilities = worker.new(self).prepare
      end
      raw_possibilities.shuffle
    end
  end
end
