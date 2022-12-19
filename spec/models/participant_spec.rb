require 'rails_helper'

RSpec.describe Participant, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    user2 = User.new(username: 'test2', password: '123123', email: 'test2@example.com')
    user2.skip_confirmation!
    user2.save
    @room = Room.create_room(user, user2, 'private_1_2')
  end

  describe 'should return nil errors while' do
    it 'simple creating' do
      participant = Participant.first
      participant.valid?
      expect(participant.errors.first).to be_nil
    end

    it 'participant creates, initiators and recipients should appears' do
      expect(User.first.initiators.count).to eq(1)
      expect(User.first.recipients.count).to eq(0)
      expect(User.last.initiators.count).to eq(0)
      expect(User.last.recipients.count).to eq(1)
    end
  end

  describe 'should return errors if' do
    it 'initiator is nil' do
      participant = Participant.new(recipient_id: 2)
      participant.valid?
      error = participant.errors.first
      expect(error.attribute).to eq(:initiator)
      expect(error.type).to eq(:blank)
    end

    it 'recipient is nil' do
      participant = Participant.new(initiator_id: 1)
      participant.valid?
      error = participant.errors.first
      expect(error.attribute).to eq(:recipient)
      expect(error.type).to eq(:blank)
    end

    it 'room_id is nil' do
      participant = Participant.new(initiator_id: 1, recipient_id: 2)
      participant.valid?
      error = participant.errors.first
      expect(error.attribute).to eq(:room)
      expect(error.type).to eq(:blank)
    end
  end
end
