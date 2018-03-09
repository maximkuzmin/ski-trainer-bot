require 'sinatra'

class TelegramApp < Sinatra::Base
  get '/' do
    'Hello World'
  end
end
