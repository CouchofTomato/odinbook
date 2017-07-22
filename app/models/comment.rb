class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :post

  def author
    self.user.profile.name
  end
end
