class Services::ProductHuntService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("https://api.producthunt.com")
    connection.query[:access_token] = ENV["PRODUCT_HUNT_ACCESS_TOKEN"]
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
