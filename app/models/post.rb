class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  def self.newsfeed(newsfeed_id_list)
    Post.where(id: newsfeed_id_list)
  end
end
