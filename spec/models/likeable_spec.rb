require 'rails_helper'

RSpec.describe Likeable, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    post = Post.new(user_id: User.first.id)
    post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"),
                        filename: 'default_preview.png', content_type: 'image/png')
    post.save
  end

  describe 'should return correct' do
    it 'count of likes if user pressed' do
      comment = Comment.create(post_id: 1, user_id: 1, body: 'Tese')
      User.first.like(comment)
      expect(comment.likes.count).to eq(1)
    end

    it 'count of likes if user pressed 3 times' do
      comment = Comment.create(post_id: 1, user_id: 1, body: 'Tese')
      User.first.like(comment)
      User.first.like(comment)
      User.first.like(comment)
      expect(comment.likes.count).to eq(1)
    end

    it 'count of likes if user like/unlike' do
      comment = Comment.create(post_id: 1, user_id: 1, body: 'Tese')
      User.first.like(comment)
      User.first.like(comment)
      expect(comment.likes.count).to eq(0)
    end
  end

  describe 'should expect error if' do
    it 'user_id is nil' do
      comment = Comment.create(post_id: 1, user_id: 1, body: 'Tese')
      expect { User.first.like }.to raise_error(ArgumentError)
    end
  end
end
