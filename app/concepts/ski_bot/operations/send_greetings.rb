module SkiBot
  class SendGreetings < Trailblazer::Operation
    step :greetings

    def greetings(options)
      options['result'] = { text: 'Привет! Рад знакомству' }
    end
  end
end
