module SkiBot
  # accepts :from_id, :previous, :client, :text, :user opts
  class SetAge < Trailblazer::Operation
    include SharedRegistrationgLogic

    AGE_REGEX = /^\d+$/

    QUESTION = 'Пожалуйста, сообщите сколько вам полных лет'
    AGAIN_QUESTION = 'Давайте вы укажете ваш возраст еще раз, но только цифрами?'

    step :decide_ask_or_store
    step :execute

    private

    def try_to_set(opts)
      opts[:text].match?(AGE_REGEX) ? set(opts) : ask_again(opts)
    end

    def set(opts)
      opts[:user].update_attribute(:age, opts[:text] )
      send_message(opts, 'Отличный возраст для лыжника!')

      SkiBot::SessionStorage.clean_previous(opts[:from_id])
      SkiBot::SetSex.({}, **opts)
    end
  end
end
