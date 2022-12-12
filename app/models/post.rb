class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :picture
  validates :picture, presence: true

  def picture_as_thumbnail
    picture.variant(resize_to_limit: [340, 340]).processed
  end
end
