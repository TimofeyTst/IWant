class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable,
         :lockable, :timeoutable, :trackable

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likeables, dependent: :destroy
  has_many :liked_comments, through: :likeables, source: :comment

  validates :email,
            presence: true,
            uniqueness: true
  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 2 }

  def liked?(comment)
    liked_comments.include?(comment)
  end

  def like(comment)
    if liked_comments.include?(comment)
      liked_comments.destroy(comment)
    else
      liked_comments << comment
    end
    public_target = "comment_#{comment.id} public_likes"
    broadcast_replace_later_to 'public_likes',
                               target: public_target,
                               partial: 'likes/like_count',
                               locals: { comment: comment }
  end
end
