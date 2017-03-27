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
end
