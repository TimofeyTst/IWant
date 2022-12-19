require 'rails_helper'

RSpec.describe CollectionSavedPost, type: :model do
  before do
    user = User.new(username: 'test', password: '123123', email: 'test@example.com')
    user.skip_confirmation!
    user.save
    post = Post.new(user_id: User.first.id)
    post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"),
                        filename: 'default_preview.png', content_type: 'image/png')
    post.save
  end

  describe 'should return nil errors if' do
    it 'user and post are exist' do
      saved_post = CollectionSavedPost.new(user_id: 1, post_id: 1)
      saved_post.valid?
      expect(saved_post.errors.first).to be_nil
    end

    it 'user saved post' do
      CollectionSavedPost.create(user_id: 1, post_id: 1)
      count = User.first.saved_posts.count
      expect(count).to eq(1)
    end

    it 'user unsaved post ' do
      CollectionSavedPost.create(user_id: 1, post_id: 1)
      CollectionSavedPost.where(user_id: 1, post_id: 1).destroy_all
      count = User.first.saved_posts.count
      expect(count).to eq(0)
    end
  end

  describe 'should except error if' do
    it 'user_id is nil' do
      saved_post = CollectionSavedPost.new
      saved_post.valid?
      error = saved_post.errors.first
      expect(error.attribute).to eq(:user)
      expect(error.type).to eq(:blank)
    end

    it 'post_id is nil' do
      saved_post = CollectionSavedPost.new(user_id: 1)
      saved_post.valid?
      error = saved_post.errors.first
      expect(error.attribute).to eq(:post)
      expect(error.type).to eq(:blank)
    end
  end
end
