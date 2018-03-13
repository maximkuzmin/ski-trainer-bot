require 'spec_helper'

describe SkiBot::Process do
  let(:api){ double(Telegram::Bot::Api, send_message: true) }
  let(:client){ instance_double(Telegram::Bot::Client, api: api) }
  let(:block){ ->{ SkiBot::Process.({}, client: client, update: update) } }

  context 'no user in db' do
    let(:update){ TelegramUpdateFactory.(text: '/start') }
    it 'should call SkiBot::UserRegistration' do
      expect(SkiBot::UserRegistration).to receive(:call).and_call_original
      block.call()
    end
  end

  context 'user is in db specified and session empty' do
    let(:training_plan){ create :training_plan }
    let!(:user){ create(:user, age: 25, sex: :female, training_plan: training_plan) }
    let(:update){ TelegramUpdateFactory.(text: '/start', user_id: user.telegram_id) }

    it 'should call SkiBot::NormalWorkFlow' do
      expect(SkiBot::NormalWorkFlow).to receive(:call).and_call_original
      block.call()
    end
  end

  context 'SessionStorage has previous_operation' do
    let!(:operation){ SkiBot::Process::QUESTION_CLASSES.sample }
    let!(:user){ create(:user) }
    let!(:update){ TelegramUpdateFactory.(text: 'text', user_id: user.telegram_id) }

    before do
      SkiBot::SessionStorage[user.telegram_id][:previous] = operation.name
    end

    it 'should call selected operation' do

      expect(operation).to receive(:call).and_call_original
      block.call
    end
  end
end
