require 'rails_helper'

RSpec.describe Friendship, type: :model do

  it "has a valid factory" do
    expect(build(:friendship)).to be_valid
  end

  it "is invalid if not accepted" do
    user = create(:user)
    friend = create(:user)
    friendship = user.friendships.build(friend: friend, accepted: false)
    friendship.save
    expect(user.friends).not_to include(friend)
  end

  it "is valid if accepted" do 
    user = create(:user)
    friend = create(:user)
    friendship = user.friendships.build(friend: friend, accepted: true)
    friendship.save
    expect(user.friends).to include(friend)
  end
end
