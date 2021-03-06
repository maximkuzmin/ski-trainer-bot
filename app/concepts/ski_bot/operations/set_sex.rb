module SkiBot
  class SetSex < Trailblazer::Operation
    include SharedRegistrationgLogic

    ANSWERS = {
      'мужчина' => 'male',
      'женщина' => 'female',
      'кто-то другой' => 'other'
    }
    QUESTION = 'Пожалуйста, сообщите нам ваш пол'
    AGAIN_QUESTION = 'Давайте попробуем еще раз?'

    step :decide_ask_or_store
    step :execute

    private

    def reply_markup
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: [ANSWERS.keys],
        one_time_keyboard: true
      )
    end

    def try_to_set(opts)
      sex = ANSWERS[ opts[:text] ]
      sex ? set(opts, sex) : ask_again(opts)
    end

    def set(opts, sex)
      opts[:user].update_attribute(:sex, sex )
      send_message(opts, 'Превосходно!', keyboard: remove_keyboard)
      clean_previous(opts[:from_id])
      SkiBot::SetTrainingPlan.({}, **opts, previous: nil)
    end
  end
end
