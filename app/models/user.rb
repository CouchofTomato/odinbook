class User < ApplicationRecord
  include Gravtastic
  gravtastic size: 80, default: 'monsterid', rating: 'X'
  after_create :make_profile
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_one :profile, dependent: :destroy
  delegate :firstname, :lastname, :date_of_birth, :gender, :website, :github_profile, :phone_number, :address_line_one, :address_line_two, :city, :country, :post_code, :odin_profile_link, :name, to: :profile 

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

  def pending_friendship
    pending_friends + notifications
  end
  
  def friends_posts
    friends.map &:posts
  end

  def newsfeed
    (friends_posts << self.posts).flatten.sort_by(&:updated_at).reverse
  end

  def friends?(user)
    self.friends.include?(user)
  end

  def pending_friends?(user)
    self.pending_friendship.include?(user)
  end

  def contacted?(user)
    friends?(user) || pending_friends?(user)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def make_profile
    self.build_profile
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
