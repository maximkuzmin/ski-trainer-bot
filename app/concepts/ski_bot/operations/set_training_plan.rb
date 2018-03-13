module SkiBot
  class SetTrainingPlan < Trailblazer::Operation
    include SharedRegistrationgLogic

    QUESTION = 'Давайте выберем тренировочный план:'
    AGAIN_QUESTION = 'Давайте попробуем выбрать план еще раз?'

    step :decide_ask_or_store
    step :execute

    private
    def reply_markup
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: TrainingPlan.pluck(:title),
        one_time_keyboard: true
      )
    end

    def try_to_set(opts)
      training_plan = TrainingPlan.find_by(title: opts[:text])
      training_plan ? set(opts, training_plan) : ask_again(opts)
    end

    def set(opts, training_plan)
      opts[:user].update_attribute(:training_plan, training_plan)
      send_message(opts, 'Отличный выбор!')
      clean_previous(opts[:from_id])
    end
  end
end
