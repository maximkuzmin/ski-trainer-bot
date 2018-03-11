# frozen_string_literal: true

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
    SkiBot::Process.({}, update: update)
    # bot.send_message chat_id: @update.message.chat.id,
    #                  text: "You wrote #{@update.message.text}"
  end

  private

  def get_payload(request)
    json = request.body.read
    # puts json
    MultiJson.load(json, symbolize_keys: true)
  end

  def bot
    @bot ||= Telegram::Bot::Client.new(ApiRequester::API_TOKEN)
  end
end
