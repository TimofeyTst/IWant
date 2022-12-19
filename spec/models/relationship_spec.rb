require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    user2 = User.new(username: 'test2', password: '123123', email: 'test2@example.com')
    user2.skip_confirmation!
    user2.save
  end

  describe 'should return nil errors while' do
    before do
      @user = User.first
      @user2 = User.last
    end

    it 'user followees' do
      Relationship.create_or_find_by(follower_id: @user.id, followee_id: @user2.id)
      expect(@user.followers.count).to eq(0)
      expect(@user.followees.count).to eq(1)

      expect(@user2.followers.count).to eq(1)
      expect(@user2.followees.count).to eq(0)
    end

    it 'user unfollowees' do
      Relationship.create_or_find_by(follower_id: @user.id, followee_id: @user2.id)
      Relationship.find_by(follower_id: @user.id, followee_id: @user2.id).destroy
      expect(@user.followers.count).to eq(0)
      expect(@user.followees.count).to eq(0)

      expect(@user2.followers.count).to eq(0)
      expect(@user2.followees.count).to eq(0)
    end
  end

  describe 'should return errors if' do
    it 'follower is nil' do
      rel = Relationship.new(followee_id: 2)
      rel.valid?
      error = rel.errors.first
      expect(error.attribute).to eq(:follower)
      expect(error.type).to eq(:blank)
    end

    it 'followee is nil' do
      rel = Relationship.new(follower_id: 1)
      rel.valid?
      error = rel.errors.first
      expect(error.attribute).to eq(:followee)
      expect(error.type).to eq(:blank)
    end
  end
end
