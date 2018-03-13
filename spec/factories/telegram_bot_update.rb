class TelegramUpdateFactory
  class << self
    def call(text: nil, user_id: nil, **options)
      data = YAML.load_file('spec/fixtures/telegram_bot_update.yml')
      result = Telegram::Bot::Types::Update.new(data)
      change_text(text, result) if text
      change_user_id(user_id, result) if user_id
      result
    end

    def change_text(text, update)
      update.message.text = text
    end

    def change_user_id(user_id, update)
      update.message.from.id = user_id
    end
  end
end
