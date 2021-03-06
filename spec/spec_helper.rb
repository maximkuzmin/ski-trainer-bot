require 'ryba'
require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'factory_bot'
require 'support/factory_bot'
require 'factories/telegram_bot_update'

ENV['RACK_ENV'] = 'test'
ENV['BOT_TOKEN'] = 'BOT_TOKEN'
ENV['SELF_URL'] = 'http://test.com'

require_relative '../load_app'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.before(:example) do
    DatabaseCleaner.clean_with(:truncation)
  end

end
