# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

user = User.new(username: 'system', password: '123123', email: 'system@test.com')
user.skip_confirmation!
user.avatar.attach(io: File.open("#{Rails.root}/spec/images/test.png"),
  filename: 'test.png', content_type: 'image/png')
user.save

user2 = User.new(username: 'system2', password: '123123', email: 'system2@test.com')
user2.skip_confirmation!
user2.save

post = Post.new(user_id: user.id, tags: '#testcase')
post.picture.attach(io: File.open("#{Rails.root}/spec/images/test.png"),
                    filename: 'test.png', content_type: 'image/png')
post.save

comment = Comment.create(post_id: post.id, user_id: user.id, body: Faker::ChuckNorris.fact)
user.like(comment)

chat_name = 'private_1_2'
chat = Chat.create(initiator: user, recipient: user2, name: chat_name)

Message.create(user_id: user.id, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
CollectionSavedPost.create(user_id: user.id, post_id: 1)

5.times do |i|
  ex_user = User.new(username: "system#{i}", password: '123123', email: "system#{i}@test.com")
  ex_user.skip_confirmation!
  ex_user.save
end

chat = Chat.create(initiator: User.find(1), recipient: User.find(3), name: 'private_1_3')
Message.create(user_id: 1, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
Message.create(user_id: 3, chat_id: chat.id, body: Faker::Hacker.say_something_smart)

chat = Chat.create(initiator: User.find(4), recipient: User.find(1), name: 'private_4_1')
Message.create(user_id: 1, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
Message.create(user_id: 1, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
Message.create(user_id: 4, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
Message.create(user_id: 4, chat_id: chat.id, body: Faker::Hacker.say_something_smart)
Message.create(user_id: 4, chat_id: chat.id, body: Faker::Hacker.say_something_smart)


# USERS_COUNT = 10
# POSTS_COUNT_PER_USER = 3
# COMMENT_COUNTS = 10
# CHATS_COUNT = 20

# MESSAGES_PER_CHAT_COUNT = 5
# SAVED_POSTS_PER_USER = 4
# FOLLOWERS_TOTAL_COUNT = 10

# USERS_COUNT.times do |i|
#   user = User.new(username: "testname_#{i}", password: '123123', email: "test_#{i}@example.com")
#   user.skip_confirmation!
#   user.save
#   POSTS_COUNT_PER_USER.times do
#     post = Post.new(user_id: user.id)
#     post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"),
#                         filename: 'default_preview.png', content_type: 'image/png')
#     post.save
#   end
# end

# COMMENT_COUNTS.times do
#   post_id = rand(1..POSTS_COUNT_PER_USER) * rand(1..USERS_COUNT)
#   user_id = rand(1..USERS_COUNT)
#   comment = Comment.create(post_id: post_id, user_id: user_id, body: Faker::ChuckNorris.fact)
#   User.find(rand(1..USERS_COUNT)).like(comment) if rand(3) == 1
# end

# CHATS_COUNT.times do
#   user1_id = rand(1..USERS_COUNT)
#   user2_id = rand(1..USERS_COUNT)
#   room_name = "private_#{user1_id}_#{user2_id}"
#   room = Room.create_or_find_by(name: room_name)
#   Participant.create(initiator_id: user1_id, recipient_id: user2_id, room_id: room.id)
#   MESSAGES_PER_CHAT_COUNT.times do
#     Message.create(user_id: user1_id, room_id: room.id, body: Faker::Hacker.say_something_smart)
#   end
# end

# SAVED_POSTS_PER_USER.times do
#   CollectionSavedPost.create(user_id: rand(1..USERS_COUNT), post_id: rand(1..POSTS_COUNT_PER_USER)*rand(1..USERS_COUNT))
# end

# FOLLOWERS_TOTAL_COUNT.times do
#   user = rand(1..USERS_COUNT)
#   user2 = user + 1
#   Relationship.create_or_find_by(follower_id: user, followee_id: user2)
# end
