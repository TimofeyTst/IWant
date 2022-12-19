require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    post = Post.new(user_id: User.first.id)
    post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"), filename: 'default_preview.png', content_type: 'image/png')
    post.save
  end

  describe 'return success' do
    it 'while creating comment' do
      comment = Comment.new(post_id: 1, user_id: 1, body: 'Tese')
      comment.valid?
      comment.save
      expect(comment.errors.first).to be_nil
    end
  end

  describe 'should expect error if' do
    it 'post_id is nil' do
      comment = Comment.new
      comment.valid?
      error = comment.errors.first
      expect(error.attribute).to eq(:post)
      expect(error.type).to eq(:blank)
    end

    it 'user_id is nil' do
      comment = Comment.new(post_id: 1)
      comment.valid?
      error = comment.errors.first
      expect(error.attribute).to eq(:user)
      expect(error.type).to eq(:blank)
    end

    it 'body is nil' do
      comment = Comment.new(post_id: 1, user_id: 1)
      comment.valid?
      error = comment.errors.first
      expect(error.attribute).to eq(:body)
      expect(error.type).to eq(:blank)
    end
  end
end
