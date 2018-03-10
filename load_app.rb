require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/activerecord'

set :database_file, 'config/database.yml'

require_relative './lib/api_requester'
require_relative './app/routes'
require_relative './app/welcome'
require_relative './app/concepts/concepts'
require_relative './app/telegram/telegram_app'
