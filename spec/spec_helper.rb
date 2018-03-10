require 'rack/test'
require 'rspec'
# require 'start'
# require 'require_all'
# require 'sinatra_autoload'

# require_rel '../lib'
# require_rel '../app'

ENV['RACK_ENV'] = 'test'

# SinatraAutoload.directories('../app', '../lib')
# require File.expand_path '../../app/app', __FILE__

# paths = [
#   File.expand_path("../environment.rb"),
#   # File.expand_path("../lib/*.rb"),
#   # File.expand_path("../app/*.rb"),
#   # File.expand_path("../app/**/*.rb"),
#   # File.expand_path("../app/**/**/*.rb")
# ]
#
# paths.each do |path|
#   Dir[path].each{ |file| puts file; require_relative(file) }
# end
require_relative '../load_app'

module RSpecMixin
  include Rack::Test::Methods

  def app; described_class; end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
