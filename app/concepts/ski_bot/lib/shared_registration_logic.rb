module SkiBot
  module SharedRegistrationgLogic
    def decide_ask_or_store(options, previous:, **)
      options['method'] = previous ? :try_to_set : :ask
    end

    def execute(options, method:, **opts)
      self.send(method, opts)
    end

    private

    def remove_keyboard
      Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    end

    def ask(opts)
      send_message opts, self.class::QUESTION, with_keyboard: true
      SkiBot::SetPreviousOperation.({}, name: self.class.name, **opts)
    end

    def ask_again(opts)
      send_message(opts, self.class::AGAIN_QUESTION, with_keyboard: true)
      SkiBot::SetPreviousOperation.({}, name: self.class.name, **opts)
    end

    def clean_previous(id)
      SkiBot::SessionStorage.clean_previous(id)
    end

    def send_message(opts, text, with_keyboard: true, keyboard: reply_markup)
      args = {
        text: text,
        chat_id: opts[:from_id],
      }
      args.merge!(reply_markup: keyboard) if with_keyboard
      opts[:client].api.send_message(**args)
    end

    def reply_markup; end
  end
end
