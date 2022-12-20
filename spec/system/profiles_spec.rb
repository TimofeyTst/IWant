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

  describe 'DELETE profile/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
    end

    scenario 'success while deleting check db' do
      count_before = User.all.count
      visit edit_user_registration_path
      sleep(0.3)
      find('.button.delete_account').click
      sleep(0.3)

      expect(count_before - User.all.count).to eq(1)
    end

    scenario 'success while deleting avatar check db' do
      visit edit_user_registration_path
      sleep(0.3)
      find('.button.delete.avatar').click
      sleep(0.3)

      expect(User.first.avatar.attached?).to eq(false)
    end

    scenario 'success while deleting avatar check page' do
      visit edit_user_registration_path
      sleep(0.3)
      find('.button.delete.avatar').click
      sleep(0.3)

      expect(page).to have_content('Avatar was deleted.')
    end
  end

  describe 'PUT/PATCH profile/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
    end

    scenario 'success while changing username' do
      visit edit_user_registration_path
      new_name = 'system_changed'
      fill_in :user_username, with: new_name
      fill_in :user_current_password, with: '123123'
      find('.form-button .button.update').click
      sleep(0.3)

      expect(User.first.username).to eq(new_name)
    end

    scenario 'success while changing password' do
      visit edit_user_registration_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123123'
      fill_in :user_password_confirmation, with: '123123123'
      fill_in :user_current_password, with: '123123'
      find('.form-button .button.update').click
      sleep(0.3)
      visit profile_path(id: 1)
      sleep(0.5)
      find('.profile_settings .main').click
      sleep(0.5)
      find('.profile_settings .menu .round-line:nth-child(3) .button_to').click
      sleep(0.5)
      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123123'
      find('.form-button .button').click
      sleep(0.1)
      expect(page).to have_content('Signed in successfully.')
    end

    # scenario 'success while changing theme' do
    #   visit profile_path(id: 1)
    #   sleep(0.5)
    #   find('.profile_settings .main').click
    #   sleep(1)
    #   find('.profile_settings .menu .round-line:nth-child(4) .button_to').click
    #   sleep(0.3)
    #   expect(User.first.theme).to eq('dark')
    # end
  end
end
