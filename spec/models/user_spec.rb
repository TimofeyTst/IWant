require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'return success' do
    it 'while creating user' do
      user = User.new(username: 'timofey', password: '123123',
                      email: 'test@gmail.com')
      user.skip_confirmation!
      user.valid?
      user.save
      expect(user.errors.first).to be_nil
    end
  end

  describe 'should expect error if' do
    before do
      user = User.new(username: 'timofey', password: '123123',
                      email: 'test@gmail.com')
      user.skip_confirmation!
      user.save
    end

    context 'email' do
      it 'is nil' do
        user = User.new(username: 'timofeyasdas', password: '123123')
        user.valid?
        error = user.errors.first
        expect(error.attribute).to eq(:email)
        expect(error.type).to eq(:blank)
      end

      it 'is taken' do
        user = User.new(username: 'timofeyasdas', password: '123123',
                        email: 'test@gmail.com')
        user.valid?
        error = user.errors.first
        expect(error.attribute).to eq(:email)
        expect(error.type).to eq(:taken)
      end
    end

    it 'password is nil' do
      user = User.new(username: 'testme', email: 'lala@gmail.com')
      user.valid?
      error = user.errors.first
      expect(error.attribute).to eq(:password)
      expect(error.type).to eq(:blank)
    end

    it 'username is nil' do
      user = User.new(password: '123123', email: 'lala@gmail.com')
      user.valid?
      error = user.errors.first
      expect(error.attribute).to eq(:username)
      expect(error.type).to eq(:blank)
    end
  end
end
