module SkiBot
  class RememberTrainingInStorage < Trailblazer::Operation
    step :set

    def set(options, from_id:, training:, **)
      SkiBot::SessionStorage[from_id][:training] = training
    end
  end
end
