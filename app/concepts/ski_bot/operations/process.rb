module SkiBot
  class Process < Trailblazer::Operation
    step :parse_update
    step :find_user
    step :find_previous_question
    step :select_operation
    step :execute_operation

    QUESTION_CLASSES = [
      SkiBot::SetAge,
      SkiBot::SetSex,
      SkiBot::SetTrainingPlan,
      SkiBot::TrainingSelection,
      SkiBot::ShowTraining,
    ].freeze

    QUESTION_CLASSES_WITH_NAMES = QUESTION_CLASSES
      .each_with_object({}){ |klass, hash| hash[klass.name] = klass }
      .freeze


    def parse_update(options, update:, **)
      message = update.message
      callback_query = update.callback_query
      return false unless message || callback_query
      if callback_query
        message = callback_query.message
        options['text'] = callback_query.data
      end
      options['message']    = message
      options['from_id']    = message.chat.id
      options['first_name'] = message.chat.first_name
      options['last_name']  = message.chat.last_name
      options['username']   = message.chat.username
      options['chat_id']    = message.chat.id
      options['text']       ||= message.text
    end

    def find_user(options, from_id:, **)
      user = User.find_by(telegram_id: from_id)
      options['user'] = user
      options['user_filled'] = user&.is_filled?
      true
    end

    def find_previous_question(options, from_id:, **)
      options['previous'] = SessionStorage[from_id][:previous]
      true
    end

    def select_operation(options, user_filled:, from_id:, previous:, **)
      options['operation'] =  if previous
                                find_operation_for(previous)
                              elsif user_filled
                                SkiBot::NormalWorkFlow
                              else
                                SkiBot::UserRegistration
                              end
    end

    def execute_operation(options, operation:, **opts)
      begin
        result = operation.call({}, **opts)
        message_text = operation['error'] || 'кажется ничего не произошло =('
      rescue => e
        result = false
        message_text = "Что-то пошло не так и произошла ошибка #{ e.inspect }"
      end
      return true if result && result.success?

      client, chat_id = opts.values_at(:client, :chat_id)
      client.api.send_message(chat_id: chat_id, text: message_text)
    end

    private

    def find_operation_for(previous_operation)
      QUESTION_CLASSES_WITH_NAMES[previous_operation] || SkiBot::NormalWorkFlow
    end
  end
end
