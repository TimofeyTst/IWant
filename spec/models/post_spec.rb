require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    Rails.application.load_seed
  end

  describe 'return success' do
    it 'while creating post' do
      post = Post.new(user_id: User.first.id)
      post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"), filename: 'default_preview.png', content_type: 'image/png')
      post.valid?
      post.save
      expect(post.errors.first).to be_nil
    end
  end

  describe 'should expect error if' do
    it 'user_id is nil' do
      post = Post.new
      post.valid?
      error = post.errors.first
      expect(error.attribute).to eq(:user)
      expect(error.type).to eq(:blank)
    end

    it 'picture is nil' do
      post = Post.new(user_id: User.first.id)
      post.valid?
      error = post.errors.first
      expect(error.attribute).to eq(:picture)
      expect(error.type).to eq(:blank)
    end
  end
end
