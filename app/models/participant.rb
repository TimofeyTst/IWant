class Participant < ApplicationRecord
  belongs_to :initiator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :room
  validates_uniqueness_of :room
end
