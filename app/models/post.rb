class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  def self.newsfeed(newsfeed_id_list)
    Post.where(id: newsfeed_id_list)
  end

  def author
    "#{self.user.profile.firstname} #{self.user.profile.lastname}"
  end

  def liked_by? user
    !(likes.where(user_id: user).empty?)
  end
end
