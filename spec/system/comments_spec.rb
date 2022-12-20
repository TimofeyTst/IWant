require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  describe 'DELETE post/:id/comments/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
    end

    scenario 'success while deleting check db' do
      count_before = Comment.all.count
      visit post_path(id: 1)
      sleep(0.3)
      find('.comment .button.delete').click
      sleep(0.3)

      expect(count_before - Comment.all.count).to eq(1)
    end

    scenario 'success while deleting check page' do
      count_before = Comment.all.count
      visit post_path(id: 1)
      sleep(0.3)
      find('.comment .button.delete').click
      sleep(0.3)

      expect(page).to have_content('Comment was destroyed')
    end
  end

  describe 'GET post/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
    end

    scenario 'trying to see reactions' do
      visit post_path(id: 1)
      count_before = Comment.first.likes.count
      expect(page).to have_content("#{count_before} reaction")
    end

    scenario 'success while creating' do
      count_before = Comment.all.count
      visit post_path(id: 1)
      fill_in :comment_body, with: Faker::ChuckNorris.fact
      find('.comment_form .field .button').click
      sleep(0.1)
      expect(Comment.all.count - count_before).to eq(1)
    end

    scenario 'success while liking' do
      count_before = Comment.first.likes.count
      visit post_path(id: 1)
      fill_in :comment_body, with: Faker::ChuckNorris.fact
      find('.like.button').click
      sleep(0.1)
      expect((Comment.first.likes.count - count_before).abs).to eq(1)
    end
  end
end
