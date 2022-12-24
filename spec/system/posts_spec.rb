require 'rails_helper'
require 'faker'

RSpec.describe 'Posts', type: :system do
  describe 'DELETE post/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
    end

    scenario 'success while deleting' do
      count_before = Post.all.count
      visit post_path(id: 1)
      sleep(0.3)
      find('.line .button.delete').click
      sleep(0.3)

      expect(count_before - Post.all.count).to eq(1)
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

    context 'posts/' do
      scenario 'trying to see posts' do
        visit posts_path
        expect(page).to have_xpath('/html/body/main/div/div[1]/div[1]/div[1]/div[1]/a/img')
      end
    end

    context 'post/:id' do
      scenario 'success while creating' do
        count_before = Post.all.count
        visit new_post_path
        fill_in :post_description, with: Faker::ChuckNorris.fact
        fill_in :post_tags, with: '#test #case'
        attach_file('post[picture]',
                    '/home/timofey/Projects/git bmstu/My Rails project/IWant/app/assets/images/favorite_pressed.png')
        find('.field .button').click
        sleep(0.1)
        expect(Post.all.count - count_before).to eq(1)
      end

      scenario 'success while saving' do
        count_before = User.first.saved_posts.count
        visit post_path(id: 1)
        find('.save.pressed.like-text').click
        sleep(0.1)
        expect((User.first.saved_posts.count - count_before).abs).to eq(1)
      end
    end
  end

  describe 'PUT/PATCH post/:id' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.3)
    end

    scenario 'success while edit description in db' do
      visit post_path(id: 1)
      find('.button.edit').click
      new_description = Faker::ChuckNorris.fact
      new_tags = '#changed #tags'
      fill_in :post_description, with: new_description
      fill_in :post_tags, with: new_tags
      find('.field .button').click
      sleep(0.3)

      expect(Post.first.description).to eq(new_description)
      expect(Post.first.tags).to eq(new_tags)
    end

    scenario 'success while edit description on post page' do
      visit post_path(id: 1)
      find('.button.edit').click
      new_description = Faker::ChuckNorris.fact
      new_tags = '#changed #tags'
      fill_in :post_description, with: new_description
      fill_in :post_tags, with: new_tags
      find('.field .button').click
      sleep(0.3)
      visit post_path(id: 1)

      expect(page).to have_content(new_description)
      expect(page).to have_content(new_tags)
    end
  end
end
