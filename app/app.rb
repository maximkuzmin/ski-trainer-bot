require 'sinatra'
require 'sinatra/reloader'
require File.expand_path '../telegram/telegram_app', __FILE__

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
end
