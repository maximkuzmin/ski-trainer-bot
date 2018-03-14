module SkiBot
  class NormalWorkFlow < Trailblazer::Operation
    step :find_operations
    step :execute

    def find_operations(options, text:, **opts)
      options[:operations] =
      case text
      when /\/start/
        [ SkiBot::HiMessage, SkiBot::TrainingSelection ]
      when /прогресс/
        [ SkiBot::TrainingSelection ]
      when /закончено/
        [ SkiBot::SetTrainingFinished ]
      else [ SkiBot::DoNotUnderstandMessage, SkiBot::TrainingSelection ]
      end
    end

    def execute(options, params:, operations:, **opts)
      operations.map { |operation| operation.call(params, **opts) }
    end
  end
end
