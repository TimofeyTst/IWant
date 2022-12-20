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

    scenario 'trying to search posts' do
      visit root_path

      find('.search .icon').click
      sleep(0.5)
      fill_in :query, with: 'testcase'
      sleep(0.5)
      find('.search_field').native.send_keys(:return)
      sleep(0.5)

      # find('.block_column:nth-child(1) .post .down .interests.buttons .save').click
      # sleep(0.3)
      # expect((User.first.saved_posts.count - count_before).abs).to eq(1)
    end
  end
end
