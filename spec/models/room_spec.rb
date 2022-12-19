require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'return success' do
    it 'while creating room' do
      room = Room.new(name: 'private_1_3')
      room.valid?
      room.save
      expect(room.errors.first).to be_nil
    end
  end

  describe 'should expect error if' do
    it 'name is nil' do
      room = Room.new
      room.valid?
      error = room.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:blank)
    end

    it 'name is taken' do
      Room.create(name: 'private_1_3')
      room = Room.new(name: 'private_1_3')
      room.valid?
      error = room.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:taken)
    end

    it 'name invalid' do
      room = Room.new(name: 'public_room_2')
      room.valid?
      error = room.errors.first
      expect(error.attribute).to eq(:name)
      expect(error.type).to eq(:invalid)
    end
  end
end
