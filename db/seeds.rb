# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
USERS_COUNT = 10
POSTS_COUNT_PER_USER = 3
COMMENT_COUNTS = 10
CHATS_COUNT = 20

MESSAGES_PER_CHAT_COUNT = 5
SAVED_POSTS_PER_USER = 4
FOLLOWERS_TOTAL_COUNT = 10

USERS_COUNT.times do |i|
  user = User.new(username: "testname_#{i}", password: '123123', email: "test_#{i}@example.com")
  user.skip_confirmation!
  user.save
  POSTS_COUNT_PER_USER.times do
    post = Post.new(user_id: user.id)
    post.picture.attach(io: File.open("#{Rails.root}/app/assets/images/default_preview.png"),
                        filename: 'default_preview.png', content_type: 'image/png')
    post.save
  end
end

COMMENT_COUNTS.times do
  post_id = rand(1..POSTS_COUNT_PER_USER) * rand(1..USERS_COUNT)
  user_id = rand(1..USERS_COUNT)
  comment = Comment.create(post_id: post_id, user_id: user_id, body: Faker::ChuckNorris.fact)
  User.find(rand(1..USERS_COUNT)).like(comment) if rand(3) == 1
end

CHATS_COUNT.times do
  user1_id = rand(1..USERS_COUNT)
  user2_id = rand(1..USERS_COUNT)
  room_name = "private_#{user1_id}_#{user2_id}"
  room = Room.create_or_find_by(name: room_name)
  Participant.create(initiator_id: user1_id, recipient_id: user2_id, room_id: room.id)
  MESSAGES_PER_CHAT_COUNT.times do
    Message.create(user_id: user1_id, room_id: room.id, body: Faker::Hacker.say_something_smart)
  end
end

SAVED_POSTS_PER_USER.times do
  CollectionSavedPost.create(user_id: rand(1..USERS_COUNT), post_id: rand(1..POSTS_COUNT_PER_USER)*rand(1..USERS_COUNT))
end

FOLLOWERS_TOTAL_COUNT.times do
  user = rand(1..USERS_COUNT)
  user2 = user + 1
  Relationship.create_or_find_by(follower_id: user, followee_id: user2)
end
