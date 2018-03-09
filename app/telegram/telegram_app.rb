require 'sinatra'

class TelegramApp < Sinatra::Base
  get '/' do
    "Hello World #{ENV['API_TOKEN']}"
  end
end
