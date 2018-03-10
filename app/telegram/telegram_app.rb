# frozen_string_literal: true

require 'sinatra'
require 'multi_json'
require 'yaml'
require 'telegram/bot'
require 'sinatra/reloader'

# Endpoint for telegram webhook and its processing
class TelegramApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    ApiRequester::SECURE_STRING
  end

  post "/webhook_#{ApiRequester::SECURE_STRING}" do
    payload = MultiJson.load(request.body.read, symbolize_keys: true)
    @update = Telegram::Types::Update.new(payload)
    bot.send_message chat_id: @update.message.chat.id,
                     text: "You wrote #{@update.message.text}"
  end

  private

  def bot
    @bot ||= Telegram::Bot::Client.new(ApiRequester::API_TOKEN)
  end
end
