require 'spec_helper'

describe Telegram::Types do
  let(:json){ "{\"update_id\":487759866,\"message\":{\"message_id\":76,\"from\":{\"id\":40441805,\"is_bot\":false,\"first_name\":\"Максим\",\"last_name\":\"Кузьмин\",\"username\":\"maximkuzmin\",\"language_code\":\"ru-RU\"},\"chat\":{\"id\":40441805,\"first_name\":\"Максим\",\"last_name\":\"Кузьмин\",\"username\":\"maximkuzmin\",\"type\":\"private\"},\"date\":1520670578,\"text\":\"and again\"}}" }
  let(:params){ MultiJson.load(json, symbolize_keys: true) }
  let(:subject){ Telegram::Types::Update.new(params) }

  context 'Update' do
    it 'has id && message' do
      expect(subject.update_id).to be
      expect(subject.message).to be_a(Telegram::Types::Message)
    end
  end

  context 'Message' do
    let(:message){ subject.message }
    it 'has id, from, date, chat, text fields' do
      expect(message.message_id).to be_a(Integer)
      expect(message.from).to be_a(Telegram::Types::User)
      expect(message.chat).to be_a(Telegram::Types::Chat)
      expect(message.date).to be_a(Integer)
      expect(message.text).to be_a(String)
    end
  end


  context 'chat' do
    let(:chat){ subject.message.chat }
    it 'has id, first_name, last_name, username, type' do
      expect(chat.id).to be_a(Integer)
      expect(chat.first_name).to be_a(String)
      expect(chat.last_name).to be_a(String)
      expect(chat.username).to be_a(String)
      expect(chat.type).to be_a(String)
    end
  end
end
