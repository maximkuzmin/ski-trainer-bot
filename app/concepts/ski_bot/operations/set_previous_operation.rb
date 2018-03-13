module SkiBot
  class SetPreviousOperation < Trailblazer::Operation
    step :set

    def set(options, from_id:, name:, **)
      SkiBot::SessionStorage[from_id][:previous] = name
    end
  end
end
