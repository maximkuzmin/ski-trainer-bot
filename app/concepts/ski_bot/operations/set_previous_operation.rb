module SkiBot
  class SetPreviousOperation < Trailblazer::Operation
    step :set

    def set(options, from_id:, name:, **)
      SkiBot::SessionStorage[from_id][:previous_operation] = name
    end
  end
end
