module SkiBot
  class HiMessage < Trailblazer::Operation
    GREETING = 'Привет! Начнем тренироваться?'
    step :greetings


    def greetings(options, client:, from_id:, **)
      client.api.send_message text: GREETING, chat_id: from_id
    end
  end
end
