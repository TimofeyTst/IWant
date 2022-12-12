class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable,
         :lockable, :timeoutable, :trackable

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: true
  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 2 }
end
