module SkiBot
  module SharedRegistrationgLogic
    def decide_ask_or_store(options, previous:, **)
      options['method'] = previous ? :try_to_set : :ask
    end

    def execute(options, method:, **opts)
      self.send(method, opts)
    end

    private

    def ask(opts)
      send_message opts, self.class::QUESTION
      SkiBot::SetPreviousOperation.({}, name: self.class.name, **opts)
    end

    def ask_again(opts)
      send_message(opts, self.class::AGAIN_QUESTION)
      SkiBot::SetPreviousOperation.({}, name: self.class.name, **opts)
    end

    def clean_previous(id)
      SkiBot::SessionStorage.clean_previous(id)
    end

    def send_message(opts, text)
      opts[:client].api.send_message(
        text: text,
        chat_id: opts[:from_id]
      )
    end
  end
end
