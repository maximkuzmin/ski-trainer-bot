require 'spec_helper'

describe SkiBot::NormalWorkFlow do
  let!(:api){ double(Telegram::Bot::Api, send_message: true) }
  let!(:client){ instance_double(Telegram::Bot::Client, api: api) }
  let!(:training_plan){ create :training_plan }
  let(:user){ create(:user, age: 25, sex: :male, training_plan: training_plan) }
  let(:operation_params){{
    from_id: user.telegram_id,
    client: client,
    previous: previous,
    text: text
  }}
  let(:block){ ->{ SkiBot::NormalWorkFlow.({}, **operation_params, text: text, user: user ) } }

  context '/start' do
    let(:text){ '/start' }

    it 'responds to /start with greeting and list of trainings' do
      expect(SkiBot::HiMessage).to receive(:call).and_call_original
      expect(SkiBot::TrainingSelection).to receive(:call).and_call_original
      block.call
    end
  end

  context 'прогресс' do
    let(:text){ 'прогресс' }

    it 'responds to прогесс with Skibot::TrainingSelection' do
      expect(SkiBot::TrainingSelection).to receive(:call).and_call_original
      block.call
    end
  end

  context 'прогресс' do
    let(:text){ 'Тренировка закончена' }

    it 'responds to прогресс with Skibot::TrainingSelection' do
      expect(SkiBot::TrainingSelection).to receive(:call).and_call_original
      block.call
    end
  end



  # context 'no previous' do
  #   let(:previous){ nil }
  #   it 'asks for sex' do
  #     expect(api)
  #       .to receive(:send_message)
  #       .with(hash_including(text: SkiBot::SetSex::QUESTION) )
  #     block.call
  #   end
  # end
  #
  # context 'with_previous' do
  #   let(:previous){ SkiBot::SetSex.name }
  #
  #   context 'bad input' do
  #     let(:text){ 'not similar with any sex' }
  #
  #     it 'asks again is not number' do
  #       expect(api)
  #         .to receive(:send_message)
  #         .with(hash_including(text: SkiBot::SetSex::AGAIN_QUESTION) )
  #       block.call
  #     end
  #   end
  #
  #   context 'proper input' do
  #     let(:text){ SkiBot::SetSex::ANSWERS.keys.sample }
  #
  #     it 'sets number, cleans after itself and calls SkiBot::SetTrainingPlan' do
  #       expect(SkiBot::SetTrainingPlan).to receive(:call)
  #       expect(SkiBot::SessionStorage).to receive(:clean_previous).with(user.telegram_id)
  #       expect(&block).to change{ user.reload.sex }
  #     end
  #   end
  # end
end
