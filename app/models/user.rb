class User < ApplicationRecord
  has_many :tweets
  has_many :likes
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end