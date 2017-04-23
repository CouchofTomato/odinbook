class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  
  has_many :friendships
  has_many :requested_friends, -> { where(friendships: { accepted: true }) }, through: :friendships, source: :friend, dependent: :destroy
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend, dependent: :destroy

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id' 
  has_many :inverse_friends, -> { where(friendships: { accepted: true }) }, through: :inverse_friendships, source: :user, dependent: :destroy
  has_many :notifications, -> { where(friendships: { accepted: false }) }, through: :inverse_friendships, source: :user, dependent: :destroy
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  
  def friends
    requested_friends + inverse_friends
  end
end
