require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'GET ' do
    before do
      Rails.application.load_seed
    end
    context 'paths for not auth user' do
      scenario 'success while registration' do
        visit new_user_registration_path
        fill_in :user_username, with: 'tst'
        fill_in :user_email, with: '123123@mail.com'
        fill_in :user_password, with: '123123'
        fill_in :user_password_confirmation, with: '123123'
        find('.form-button .button').click
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      end

      # scenario 'some paths can`t show' do
      #   close_paths = ['albums', 'interests/saved', new_user_session_path,
      #                  'posts/new', 'chats']

      #   # post_comments_path(post_id: 1) room_path(id: 1) edit_post_path(id: 1), chat_path(id: 1)

      #   close_paths.each do |path|
      #     p "================================="
      #     p path
      #     sleep(2)
      #     visit 'chats'
      #     sleep(2)
      #     p "================================="
      #     expect(current_path).to eq new_user_session_path
      #   end
      # end

      scenario 'some paths can be shown' do
        # can`t open followees and followers paths`
        open_paths = [root_path, search_path, posts_path, post_path(id: 1)]
        open_paths.each do |path|
          visit path
          expect(current_path).to eq path
        end
      end

      scenario 'with changing locale' do
        visit root_path({ locale: 'en' })
        expect(current_path).to have_content 'en'
        visit root_path({ locale: 'ru' })
        expect(current_path).to have_content 'ru'
      end
    end

    context 'for auth user' do
      scenario 'success while login' do
        visit new_user_session_path
        fill_in :user_username, with: 'system'
        fill_in :user_password, with: '123123'
        find('.form-button .button').click
        sleep(0.1)
        expect(current_path).to eq(root_path({ locale: 'en' }))
      end
    end
    scenario 'with changing locale' do
      visit root_path({ locale: 'en' })
      expect(current_path).to have_content 'en'
      visit root_path({ locale: 'ru' })
      expect(current_path).to have_content 'ru'
    end
  end
end
