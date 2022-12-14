class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :likeables, dependent: :destroy
  has_many :likes, through: :likeables, source: :user

  validates :body, presence: true
end
