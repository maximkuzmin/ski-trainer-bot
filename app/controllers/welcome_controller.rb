# frozen_string_literal: true

# Controller for basic web interface
class WelcomeController < Sinatra::Base
  get '/' do
    'Welcome!'
  end
end
