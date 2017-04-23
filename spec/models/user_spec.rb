require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  
  it "has many requested friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user.requested_friends).to include(user2)
  end
  
  it "has many pending friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: false)
    expect(user.pending_friends).to include(user2)
  end
  
  it "has many inverse_friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user2.inverse_friends).to include(user)
  end
  
  it "has many notifications" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: false)
    expect(user2.notifications).to include(user)
  end
  
  it "has many friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user.friends).to include(user2)
    expect(user2.friends).to include(user)
  end
  
  it "has one profile" do
    user = create(:user)
    profile = user.build_profile(:profile)
    profile.save
    expect(profile.user).to eql user
  end
    
end
