# frozen_string_literal: true

# Controller for basic web interface
class Welcome < Sinatra::Base
  get '/' do
    'Welcome!'
  end
end
