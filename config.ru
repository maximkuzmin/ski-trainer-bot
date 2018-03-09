require 'sinatra'
require 'sinatra/reloader'

# recursively require app folder
PATHS = [
  File.expand_path("app/*.rb"),
  File.expand_path("app/**/*.rb"),
  File.expand_path("lib/*.rb"),
]

PATHS.each do |path|
  Dir[path].each{ |file| require_relative(file) }
end

# map classes to specific routes
Routes.call(self)

# heroku specified logging
$stdout.sync = true
