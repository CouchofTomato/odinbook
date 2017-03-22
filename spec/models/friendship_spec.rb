require 'rails_helper'

RSpec.describe Friendship, type: :model do

  it "has a valid factory" do
    expect(build(:friendship)).to be_valid
  end

  it "is invalid if not accepted" do
    user = create(:user)
    friend = create(:user)
    friendship = build(:friendship, user: user, friend: friend, accepted: false)
    expect(user.friends).not_to include(friend)
  end
end