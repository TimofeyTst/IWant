require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    user2 = User.new(username: 'test2', password: '123123', email: 'test2@example.com')
    user2.skip_confirmation!
    user2.save
  end

  describe 'nil errors' do
    it 'while creating chat' do
      chat = Chat.new(
        initiator_id: 1, recipient_id: 2, name: 'private_1_2'
      )
      chat.valid?
      chat.save
      expect(chat.errors.first).to be_nil
    end

    it 'chat creates & initiators and recipients should appears' do
      Chat.create(initiator: User.first, recipient: User.last, name: 'private_1_2')
      expect(User.first.initiators.count).to eq(1)
      expect(User.first.recipients.count).to eq(0)
      expect(User.last.initiators.count).to eq(0)
      expect(User.last.recipients.count).to eq(1)
    end
  end

  describe 'should expect error if' do
    it 'initiator is nil' do
      chat = Chat.new
      chat.valid?
      error = chat.errors.first
      expect(error.attribute).to eq(:initiator)
      expect(error.type).to eq(:blank)
    end

    it 'recipient is nil' do
      chat = Chat.new(initiator: User.last)
      chat.valid?
      error = chat.errors.first
      expect(error.attribute).to eq(:recipient)
      expect(error.type).to eq(:blank)
    end

    it 'name is nil' do
      chat = Chat.new(initiator: User.first, recipient: User.last)
      chat.valid?
      error = chat.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:blank)
    end

    it 'name is taken' do
      Chat.create(initiator: User.first, recipient: User.last, name: 'private_1_2')
      chat = Chat.new(initiator: User.first, recipient: User.last, name: 'private_1_2')
      chat.valid?
      error = chat.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:taken)
    end

    it 'name invalid' do
      chat = Chat.new(initiator: User.first, recipient: User.last, name: 'public_chat_1_2')
      chat.valid?
      error = chat.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:invalid)
    end
  end
end
