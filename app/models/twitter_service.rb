class TwitterService
  attr_reader :connection

  def initialize(user)
    @connection = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def post(idea_id)
    message = "If I were to make " + Idea.find(idea_id).composite + "a thing, would you be into it?"
    connection.update(message)
  end
end
