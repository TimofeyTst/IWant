class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :body, presence: true

  after_create_commit { broadcast_append_to room }
end
