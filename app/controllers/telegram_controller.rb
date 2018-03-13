# frozen_string_literal: true
require 'yaml'
require 'telegram/bot'

# Controller for telegram webhook endpoint and its processing
class TelegramController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    ApiRequester::SECURE_STRING
  end

  post "/webhook_#{ApiRequester::SECURE_STRING}" do
    payload = get_payload(request)
    update = Telegram::Bot::Types::Update.new(payload)
    puts payload.to_yaml if ENV['RACK_ENV'] == 'development'
    return if update.edited_message
    SkiBot::Process.(params, update: update, client: client)
    # return if ENV['RACK_ENV'] == 'test'
    # client.api.send_message text: "hello!, you wrote: #{payload.to_yaml}",
    #                         chat_id: update.message.chat&.id
  end

  private

  def get_payload(request)
    json = request.body.read
    MultiJson.load(json, symbolize_keys: true)
  end

  def client
    @client ||= Telegram::Bot::Client.new(ApiRequester::API_TOKEN)
  end
end
