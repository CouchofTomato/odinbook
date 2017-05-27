require 'rails_helper'

RSpec.describe Post, type: :model do

  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without content" do
    post = build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("can't be blank")
  end

  describe '#author' do
    it 'returns the name of the post author' do
      user = create(:user)
      user.build_profile(attributes_for(:profile, firstname: "Austin", lastname: "Mason"))
      post = user.posts.create(attributes_for(:post))
      post.comments.create(content: "this is a test", user: user)
      expect(post.author).to eql "Austin Mason"
    end
  end
end
