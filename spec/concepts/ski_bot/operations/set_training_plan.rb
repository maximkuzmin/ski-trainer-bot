require 'spec_helper'

describe SkiBot::SetTrainingPlan do
  # TODO: make it work
  # let!(:api){ double(Telegram::Bot::Api, send_message: true) }
  # let!(:client){ instance_double(Telegram::Bot::Client, api: api) }
  # let!(:training_plan1){ create :training_plan, title: Ryba::Company.name }
  # let!(:training_plan2){ create :training_plan, title: Ryba::Company.name }
  # let(:user){ create(:user, age: 25) }
  # let(:text){ 'some text' }
  # let(:operation_params){{
  #   from_id: user.telegram_id,
  #   client: client,
  #   previous: previous
  # }}
  # let(:block){ ->{ SkiBot::SetTrainingPlan.({}, **operation_params, text: text, user: user ) } }
  #
  # context 'no previous' do
  #   let(:previous){ nil }
  #   it 'asks for training plan' do
  #     expect(api)
  #       .to receive(:send_message)
  #       .with(hash_including(text: SkiBot::SetTrainingPlan::QUESTION) )
  #     block.call
  #   end
  # end
  #
  # context 'with_previous' do
  #   let(:previous){ SkiBot::SetTrainingPlan.name }
  #
  #   context 'bad input' do
  #     let(:text){ 'not similar with any title' }
  #
  #     it 'asks again is not number' do
  #       expect(api)
  #         .to receive(:send_message)
  #         .with(hash_including(text: SkiBot::SetTrainingPlan::AGAIN_QUESTION) )
  #       block.call
  #     end
  #   end
  #
  #   context 'proper input' do
  #     let(:text){ SkiBot::SetTrainingPlan::ANSWERS.keys.sample }
  #
  #     it 'sets number, cleans after itself and calls SkiBot::SetTrainingPlan' do
  #       expect(SkiBot::SetTrainingPlan).to receive(:call)
  #       expect(SkiBot::SessionStorage).to receive(:clean_previous).with(user.telegram_id)
  #       expect(&block).to change{ user.reload.sex }
  #     end
  #   end
  # end
end
