class Chat < ApplicationRecord
  belongs_to :initiator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy
  validates :name, presence: true, format: { with: /private_\d+_\d+/,
                                             message: 'Must be like private_id1_id2' }

  validates_uniqueness_of :name
end
