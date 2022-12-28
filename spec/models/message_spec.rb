require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    Rails.application.load_seed
  end

  describe 'return success' do
    it 'while creating message' do
      message = Message.new(user_id: 1, chat_id: 1, body: 'Tese')
      message.valid?
      message.save
      expect(message.errors.first).to be_nil
    end
  end

  describe 'should expect error if' do
    it 'user_id is nil' do
      message = Message.new
      message.valid?
      error = message.errors.first
      expect(error.attribute).to eq(:user)
      expect(error.type).to eq(:blank)
    end

    it 'chat_id is nil' do
      message = Message.new(user_id: 1)
      message.valid?
      error = message.errors.first
      expect(error.attribute).to eq(:chat)
      expect(error.type).to eq(:blank)
    end

    it 'body is nil' do
      message = Message.new(user_id: 1, chat_id: 1)
      message.valid?
      error = message.errors.first
      expect(error.attribute).to eq(:body)
      expect(error.type).to eq(:blank)
    end
  end
end
