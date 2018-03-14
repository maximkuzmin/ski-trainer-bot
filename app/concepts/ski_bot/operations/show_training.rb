module SkiBot
  class ShowTraining < Trailblazer::Operation
    include SharedRegistrationgLogic

    step :find_training
    step :try_to_set

    def find_training(options, from_id:, **opts)
      options['training'] = SessionStorage[from_id][:training] || options[:training]
      SkiBot::RememberTrainingInStorage.({}, training: options[:training], from_id: from_id)
      SkiBot::SetPreviousOperation.({}, name: self.class.name, from_id: from_id, **opts)
    end

    def try_to_set(options, text:,  **opts)
      case text
      when /finish/
        set_as_finished(**opts)
      when /cancel/
        SkiBot::SessionStorage.set opts[:from_id], nil
        SkiBot::TrainingSelection.({}, **opts, text: text)
      else
        show(opts)
      end
    end

    private

    def basic_keyboard
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['/start'])
    end

    def set_as_finished(opts)
      user, training, from_id = opts.values_at(:user, :training, :from_id)
      user.training_participations.create(training: training)
      SkiBot::SessionStorage.set from_id, nil
      send_message(opts, 'Поздравляем с завершением тренировки!', keyboard: basic_keyboard)
    end

    def reply_markup_for(training)
      buttons = []
      buttons.push Telegram::Bot::Types::InlineKeyboardButton.new(
        text: "Отметить тренировку как законченную #{training.title}",
        callback_data: 'finish'
      )
      buttons.push Telegram::Bot::Types::InlineKeyboardButton.new(
        text: "Назад к тренировкам",
        callback_data: '/cancel'
      )
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
    end

    def show(options)
      message_text = compose_text_for(options[:training], options[:user])
      send_message(options, message_text, keyboard: reply_markup_for(options[:training]))
    end

    def compose_text_for(training, user)
      participated = training.training_participations.select {|tp| tp.user_id == user.id }

      result = ''
      result << "Тренировка тренировочного плана #{user.training_plan.title}: #{training.title}.\n"
      result << "Завершена #{participated.count} раз.\n"
      result << "#{training.description}\n"
      result
    end
  end
end
