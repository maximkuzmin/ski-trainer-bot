module SkiBot
  class SendGreetings < Trailblazer::Operation
    GREETING = 'Здравствуйте! Рад знакомству! Сейчас вам понадобиться ответить на несколько вопросов.'
    step :greetings


    def greetings(options, client:, from_id:, **)
      client.api.send_message text: GREETING, chat_id: from_id
    end
  end
end
