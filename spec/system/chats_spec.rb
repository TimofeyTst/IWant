require 'rails_helper'

RSpec.describe 'Chats', type: :system do
  describe 'GET chats/' do
    before do
      Rails.application.load_seed

      visit new_user_session_path
      fill_in :user_username, with: 'system'
      fill_in :user_password, with: '123123'
      find('.form-button .button').click
      sleep(0.1)
      @users = User.first.initiators + User.first.recipients
    end

    scenario 'trying to send a message' do
      visit chats_path
      @users.each do |user|
        room = Room.where(name: ["private_1_#{user.id}", "private_#{user.id}_1"]).first
        count_before = room.messages.count

        find(".chat_#{user.id}").click
        fill_in :message_body, with: Faker::ChuckNorris.fact
        find('.msg-form .field .button').click
        sleep(1)

        expect(room.messages.count - count_before).to eq(1)
      end
    end

    scenario 'trying to switch chats' do
      visit chats_path
      @users.each do |user|
        find(".chat_#{user.id}").click
        sleep(0.1)
        expect(current_path).to eq(chat_path(id: user.id, locale: I18n.locale))
      end
    end
  end
end
