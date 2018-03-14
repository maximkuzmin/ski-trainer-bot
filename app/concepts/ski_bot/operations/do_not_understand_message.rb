module SkiBot
  class DoNotUnderstandMessage < Trailblazer::Operation
    GREETING = 'Я не очень понял что произошло(я ведь бот), но мы можем потренироваться ;)'
    step :greetings


    def greetings(options, client:, from_id:, **)
      client.api.send_message text: GREETING, chat_id: from_id
    end
  end
end
