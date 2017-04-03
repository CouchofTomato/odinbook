require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  it "is invalid without content" do
    comment = build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank")
  end
end
