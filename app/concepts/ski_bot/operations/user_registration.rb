module SkiBot
  # needs update, from_id
  class UserRegistration < Trailblazer::Operation
    step :find_or_initialize_user
    step :persist_if_new
    step :greet_user_and_then_start_fill

    def find_or_initialize_user(options, from_id:, **)
      user = User.where( telegram_id: from_id ).first_or_initialize
      options['is_new'] = user.new_record?
      options['user'] = user
    end

    def persist_if_new(options, is_new:, user:, **)
      user.save
    end

    def greet_user_and_then_start_fill(options, is_new:, user:, **opts)
      SkiBot::SendGreetings.({}, **opts) if is_new
      return SkiBot::SetAge.({}, **opts) unless user.age
      return SkiBot::SetSex.({}, **opts) unless user.sex
      return SkiBot::SetTrainingPlan.({}, **opts) unless user.training_plan
    end
  end
end
