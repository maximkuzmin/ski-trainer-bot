require 'spec_helper'

describe TrainingParticipation do
  context 'basic interfaces' do
    let!(:training_plan){ create :training_plan }
    let!(:user){ create :user, training_plan: training_plan }
    let!(:training){ create :training, training_plan: training_plan }
    let(:subject){ create :training_participation, user: user, training: training }

    it 'should have user and training' do
      expect(subject.user).to eq(user)
      expect(subject.training).to eq(training)
    end

    it 'should have training_plan' do
      expect(subject.training_plan).to eq(training_plan)
    end
  end
end
