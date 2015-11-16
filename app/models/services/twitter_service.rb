class Services::TwitterService
  attr_reader :connection

  def initialize
    @connection = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    end
  end

  def raw_possibilities
    possibilities = {}
    posts = parse(connection.get("/v1/posts"))[:posts]
    posts.each do |post|
      possibilities[post[:discussion_url]] = post[:tagline]
    end
    possibilities
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
