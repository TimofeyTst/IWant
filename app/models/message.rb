class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :body, presence: true

  after_create_commit { broadcast_append_to chat }
end
