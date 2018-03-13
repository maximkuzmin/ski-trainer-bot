require 'spec_helper'

describe SkiBot::SetAge do
  let!(:api){ double(Telegram::Bot::Api, send_message: true) }
  let!(:client){ instance_double(Telegram::Bot::Client, api: api) }
  let(:user){ create(:user) }
  let(:text){ 'some text' }
  let(:operation_params){{
    from_id: user.telegram_id,
    client: client,
    previous: previous
  }}
  let(:block){ ->{ SkiBot::SetAge.({}, **operation_params, text: text, user: user ) } }

  context 'no previous' do
    let(:previous){ nil }
    it 'asks for ages' do
      expect(api)
        .to receive(:send_message)
        .with(hash_including(text: SkiBot::SetAge::QUESTION) )
      block.call
    end
  end

  context 'with_previous' do
    let(:previous){ SkiBot::SetAge.name }

    context 'bad input' do
      let(:text){ 'not number at all!' }

      it 'asks again is not number' do
        expect(api)
          .to receive(:send_message)
          .with(hash_including(text: SkiBot::SetAge::AGAIN_QUESTION) )
        block.call
      end
    end

    context 'proper input' do
      let(:text){ '42' }

      it 'sets number, cleans after itself and calls SkiBot::SetSex' do
        expect(SkiBot::SetSex).to receive(:call)
        expect(SkiBot::SessionStorage).to receive(:clean_previous).with(user.telegram_id)
        expect(&block).to change{ user.reload.age }.to(42)
      end
    end
  end
end
