module SkiBot
  class TrainingSelection < Trailblazer::Operation
    include SharedRegistrationgLogic
    step :understand_what_to_do
    step :execute

    def understand_what_to_do(options, previous:, text:, **opts)
      options['method'] = previous ? :try_to_set : :show
    end

    def execute(options, method:, **opts)
      self.send(method, opts)
    end

    private

    def reply_markup_for(trainings)
      buttons = trainings.map do |training|
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: training.title,
          callback_data: training.id
        )
      end
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
    end

    def try_to_set(options)
      case options[:text]
      when *Training.pluck(:id).map(&:to_s)
        SkiBot::ShowTraining.({}, **options, training: Training.find(options[:text]))
      else
        show(options)
      end
    end

    def show(options)
      unless options[:user].try(:training_plan)
        SkiBot::SetTrainingPlan({}, options)
      end
      trainings = options[:user].training_plan
                                .trainings
                                .preload(:training_participations)
                                .sort_by(&:title)
      message_text = compose_text_for(trainings, options[:user])
      SkiBot::SetPreviousOperation.({}, name: self.class.name, **options)
      send_message(options, message_text, keyboard: reply_markup_for(trainings))
    end

    def compose_text_for(trainings, user)
      participated_count = 0
      training_strings = trainings.map do |training|
        participated = training.training_participations
                               .select {|tp| tp.user_id == user.id }
        participated_count += 1 if participated.count > 0
        "#{training.title}: завершено #{participated.count} раз."
      end
      "Тренировки тренировочного плана #{user.training_plan.title}:
       #{training_strings.join('\n')}
       Всего вы сделали #{user.training_participations.count} тренировок.
       Вам осталось завершить #{trainings.count - participated_count} тренировок.
       Выберите одну из них и начнем =)
      "
    end
  end
end
