class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
  def can_follow
    User.where.not(id: followeds.map(&:followed_id))
    #User.where.not(id: followeds.map(&:followed_id)).limit(4)
  end
end