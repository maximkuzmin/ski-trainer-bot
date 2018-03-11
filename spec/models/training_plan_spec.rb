require 'spec_helper'

describe TrainingPlan do
  context 'basic interfaces' do
    let(:training_plan){ create :training_plan }
    let!(:user1){ create :user, training_plan: training_plan }
    let!(:user2){ create :user, training_plan: training_plan }
    let!(:training1){ create :training, training_plan: training_plan }
    let!(:training2){ create :training, training_plan: training_plan }

    it 'should have users' do
      expect(training_plan.users).to include(user1)
      expect(training_plan.users).to include(user2)
    end

    it 'should have trainings' do
      expect(training_plan.trainings).to include(training1)
      expect(training_plan.trainings).to include(training2)
    end
  end
end
