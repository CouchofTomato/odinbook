require 'rails_helper'

RSpec.describe Profile, type: :model do

  it "has a valid factory" do
    expect(build(:profile)).to be_valid
  end

  it "is invalid without a firstname" do
    profile = build(:profile, firstname: nil)
    profile.valid?
    expect(profile.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
    profile = build(:profile, lastname: nil)
    profile.valid?
    expect(profile.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without a date of birth" do
    profile = build(:profile, date_of_birth: nil)
    profile.valid?
    expect(profile.errors[:date_of_birth]).to include("can't be blank")
  end

  it "is invalid without a user" do
    profile = build(:profile, user: nil)
    profile.valid?
    expect(profile.errors[:user]).to include("can't be blank")
  end
end
