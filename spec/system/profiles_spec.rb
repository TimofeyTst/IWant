require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  describe 'GET profile/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.3)
    end

    scenario 'trying to save post' do
      count_before = User.first.saved_posts.count
      visit profile_path(id: User.first.id)
      sleep(0.3)

      find('.block_column:nth-child(1) .post .down .button').click
      sleep(0.3)

      find('.block_column:nth-child(1) .post .down .interests.buttons .save').click
      sleep(0.3)
      expect((User.first.saved_posts.count - count_before).abs).to eq(1)
    end

    scenario 'trying to see post' do
      visit profile_path(id: User.first.id)
      find('.block_column:nth-child(1) .post .post_picture').click
      sleep(0.3)
      expect(current_path).to eq(post_path(id: User.first.posts.first.id, locale: I18n.locale))
    end

    scenario 'trying to see followers' do
      visit profile_path(id: User.first.id)
      find('.followers_btn').click
      sleep(0.3)
      expect(current_path).to eq(profile_followers_path(id: User.first.id, locale: I18n.locale))
    end

    scenario 'trying to see followees' do
      visit profile_path(id: User.first.id)
      find('.followees_btn').click
      sleep(0.3)
      expect(current_path).to eq(profile_followees_path(id: User.first.id, locale: I18n.locale))
    end

    scenario 'trying to follow and unfollow' do
      count_before = User.last.followers.count
      visit profile_path(id: User.last.id)
      find('.sub_btn').click
      sleep(0.3)
      expect((User.last.followers.count - count_before).abs).to eq(1)
      find('.sub_btn').click
      sleep(0.3)
      expect((User.last.followers.count - count_before).abs).to eq(0)
    end

    scenario 'trying to send a message' do
      visit profile_path(id: User.last.id)
      find('.msg_btn').click
      sleep(0.3)
      expect(current_path).to eq(chat_path(id: User.last.id, locale: I18n.locale))
    end
  end
end
