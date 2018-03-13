module SkiBot
  class SetTrainingPlan < Trailblazer::Operation
    include SharedRegistrationgLogic

    # ANSWERS = {
    #   'мужчина' => 'male',
    #   'женщина' => 'female',
    #   'кто-то другой' => 'other'
    # }
    # QUESTION = 'Пожалуйста, сообщите нам ваш пол'
    # AGAIN_QUESTION = 'Давайте попробуем еще раз?'
    #
    # step :decide_ask_or_store
    # step :execute
    #
    # private
    #
    # def try_to_set(opts)
    #   sex = ANSWERS[ opts[:text] ]
    #   sex ? set(opts, sex) : ask_again(opts)
    # end
    #
    # def set(opts, sex)
    #   opts[:user].update_attribute(:sex, sex )
    #   send_message(opts, 'Превосходно!')
    #   clean_previous(opts[:from_id])
    #   SkiBot::SetSex({}, **opts)
    # end
  end
end
