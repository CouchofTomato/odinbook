require 'delegate'

class FriendshipDecorator < SimpleDelegator
  def name
    User.find(user_id).profile.name
  end

  def profile
    User.find(user_id).profile
  end
end
