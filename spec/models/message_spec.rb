require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    room = Room.new(name: "private_1_3")
    room.save
  end

  describe 'return success' do
    it 'while creating message' do
      message = Message.new(user_id: 1, room_id: 1, body: 'Tese')
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

    it 'room_id is nil' do
      message = Message.new(user_id: 1)
      message.valid?
      error = message.errors.first
      expect(error.attribute).to eq(:room)
      expect(error.type).to eq(:blank)
    end

    it 'body is nil' do
      message = Message.new(user_id: 1, room_id: 1)
      message.valid?
      error = message.errors.first
      expect(error.attribute).to eq(:body)
      expect(error.type).to eq(:blank)
    end
  end
end
