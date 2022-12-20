require 'rails_helper'

RSpec.describe "Search", type: :system do
  describe 'GET /search' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.3)
    end

    scenario 'trying to search posts and expect path' do
      visit root_path

      find('.search .icon').click
      sleep(0.5)
      fill_in :query, with: 'testcase'
      sleep(0.5)
      find('.search_field').native.send_keys(:return)
      sleep(0.5)

      expect(current_path).to eq(search_path(locale: I18n.locale))
    end

    scenario 'trying to search posts and expect result' do
      visit root_path

      find('.search .icon').click
      sleep(0.5)
      fill_in :query, with: 'testcase'
      sleep(0.5)
      find('.search_field').native.send_keys(:return)
      sleep(0.5)
      expect(page).to have_xpath('/html/body/main/div/div[1]/div[1]/div/div[1]/a/img')
    end
  end
end
