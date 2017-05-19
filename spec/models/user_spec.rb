require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { is_expected.to callback(:make_profile).after(:create) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  
  it "has many requested friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user.requested_friends).to include(user2)
  end

  it 'deletes friendships when the user is deleted' do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect { user.destroy }.to change { Friendship.count }.by(-1)
  end
  
  it "has many pending friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: false)
    expect(user.pending_friends).to include(user2)
  end

  it 'deletes the pending friend request when the user is deleted' do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2)
    expect { user.destroy }.to change { Friendship.count }.by(-1)
  end
  
  it "has many inverse_friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user2.inverse_friends).to include(user)
  end

  it 'deletes the inverse_friends when the user is deleted' do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect { user2.destroy }.to change { Friendship.count }.by(-1)
  end
  
  it "has many notifications" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: false)
    expect(user2.notifications).to include(user)
  end

  it 'deletes the notification when the user is deleted' do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: false)
    user.destroy
    expect(user2.notifications).not_to include(user)
  end
  
  it "has many friends" do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    expect(user.friends).to include(user2)
    expect(user2.friends).to include(user)
  end

  it 'deletes the user from another users friends list when the user is destroyed' do
    user = create(:user)
    user2 = create(:user)
    user.friendships.create(friend: user2, accepted: true)
    user.destroy
    expect(user2.friends).not_to include(user)
  end
  
  it "has one profile" do
    user = create(:user)
    profile = user.build_profile(attributes_for(:profile))
    profile.save
    expect(profile.user).to eql user
  end

  it 'deletes the users profile when the user is deleted' do
    user = create(:user)
    profile = user.build_profile(attributes_for(:profile))
    profile.save
    expect { user.destroy }.to change { Profile.count }.by(-1)
  end
  
  describe '#newsfeed' do
    it "returns an array of posts from the user and their friends" do
      user = create(:user)
      user.posts.create(attributes_for(:post))
      3.times do
        user2 = create(:user)
        user2.posts.create(attributes_for(:post))
        user.friendships.create(friend: user2, accepted: true)
      end
      3.times do
        user2 = create(:user)
        user2.posts.create(attributes_for(:post))
        user2.friendships.create(friend: user, accepted: true)
      end
      expect(user.newsfeed.count).to eql 7
    end
  end
end
