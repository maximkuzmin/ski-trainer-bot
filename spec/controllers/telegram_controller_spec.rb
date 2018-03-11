require 'spec_helper'

describe TelegramController do
  it 'should work at least' do
    get '/'
    expect(last_response.status).to eq(200)
  end

  context '#webhook' do
    let(:payload_json){
      File.read('spec/fixtures/message_update.json')
    }
    let(:params){ MultiJson.load(payload_json) }
    let(:endpoint_url){ "/webhook_#{ApiRequester::SECURE_STRING}" }

    it 'webhook should call SkiBot::Process operation' do
      expect(SkiBot::Process).to receive(:call)
      post endpoint_url, params.to_json
    end
  end
end
