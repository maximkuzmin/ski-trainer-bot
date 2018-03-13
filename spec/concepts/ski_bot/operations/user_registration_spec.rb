require 'spec_helper'

describe SkiBot::UserRegistration do
  let(:from_id){ rand(1000) }
  let(:block){ ->{ SkiBot::UserRegistration.({}, from_id: from_id) } }

  context 'no user in db' do
    before(:each) do
      allow(SkiBot::SetAge).to receive(:call)
      allow(SkiBot::SendGreetings).to receive(:call)
    end

    it 'creates_user' do
      expect(&block).to change{ User.where(telegram_id: from_id).count }.by(1)
      block.call
    end

    it 'greets user and asks age if user empty' do
      expect(SkiBot::SetAge).to receive(:call)
      expect(SkiBot::SendGreetings).to receive(:call)
      block.call
    end
  end
end
