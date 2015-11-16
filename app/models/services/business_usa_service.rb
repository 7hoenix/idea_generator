class Services::BusinessUSAService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://api-business.usa.gov")
    connection.query[:api_key] = ENV["BUSINESS_USA_API_KEY"]
  end

  def raw_possibilities
    posts = parse(connection.get("/success_story/json?size=50&offset=25"))
    possibilities = {}
    posts.first.last[:docs].each do |post|
      possibilities[post[:learn_more_url]] = post[:title]
    end
    possibilities
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

