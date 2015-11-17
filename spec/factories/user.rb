FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    uid "12345"
    oauth_token ENV["twitter_user_token"]
    oauth_token_secret ENV["twitter_user_secret"]
  end
end
