require 'spec_helper'

describe TelegramApp do
  it 'should work at least' do
    get '/'
    expect(last_response.status).to eq(200)
  end
end
