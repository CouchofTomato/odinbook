class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates :user_id, uniqueness: { scope: :friend_id }
  
  def self.pending_requests(current_user)
    Friendship.where(friend_id: current_user.id, accepted: false)
  end

end
