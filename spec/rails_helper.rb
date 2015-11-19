require "simplecov"
SimpleCov.start "rails"

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'support/controller_helpers'
require 'webmock'
require 'vcr'

ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<twitter_api_key>") { ENV["TWITTER_API_KEY"] }
  config.filter_sensitive_data("<twitter_secret>") { ENV["TWITTER_API_SECRET"] }
  config.filter_sensitive_data("<twitter_user_token>") { ENV["twitter_user_token"] }
  config.filter_sensitive_data("<twitter_user_secret>") { ENV["twitter_user_secret"] }
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      uid: "1234",
      provider: "twitter",
      info: {
        image: "cake"
      },
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Justin",
          screen_name: "Justin Holzmann",
          profile_banner_url: "cake"
        }
      },
      credentials: {
        token: ENV["twitter_user_token"],
        secret: ENV["twitter_user_secret"]
      }
    })
  end

  config.include Capybara::DSL, type: :feature
  Capybara.app = IdeaGenerator::Application
  stub_omniauth

  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end
