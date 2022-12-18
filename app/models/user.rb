class User < ApplicationRecord
  after_create_commit { broadcast_append_to 'users' }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable,
         :lockable, :trackable

  # scope :all_except, ->(user) { initiators + recipients }
  has_many :messages, dependent: :destroy

  enum theme: %i[dark light]

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likeables, dependent: :destroy
  has_many :liked_comments, through: :likeables, source: :comment

  # This access the Relationship object
  has_many :followed_users,
           foreign_key: :follower_id,
           class_name: 'Relationship',
           dependent: :destroy

  # This accesses the user through the relationship object
  has_many :followees,
           through: :followed_users,
           dependent: :destroy

  # This access the Relationship object
  has_many :following_users,
           foreign_key: :followee_id,
           class_name: 'Relationship',
           dependent: :destroy

  # This accesses the user through the relationship object
  has_many :followers,
           through: :following_users,
           dependent: :destroy

  # This access the Participant object
  has_many :initiatoring_users,
           foreign_key: :initiator_id,
           class_name: 'Participant',
           dependent: :destroy

  # This accesses the user through the participant object
  has_many :initiators,
           through: :initiatoring_users,
           source: :recipient,
           dependent: :destroy

  # This access the Participant object
  has_many :recipient_users,
           foreign_key: :recipient_id,
           class_name: 'Participant',
           dependent: :destroy

  # This accesses the user through the participant object
  has_many :recipients,
           through: :recipient_users,
           source: :initiator,
           dependent: :destroy

  has_many :CollectionSavedPost, dependent: :destroy

  has_many :saved_posts, source: :post, through: :CollectionSavedPost

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
