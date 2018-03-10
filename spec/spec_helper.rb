require 'rack/test'
require 'rspec'

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
end
