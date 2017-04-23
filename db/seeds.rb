require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  user = User.new
  user.email = Faker::Internet.unique.email
  user.password = "password"
  user.password_confirmation = "password"
  user.save
end

User.all.each do |user|
  profile = user.build_profile
  profile.firstname = Faker::Name.first_name
  profile.lastname = Faker::Name.last_name
  profile.date_of_birth = Faker::Date.between(50.years.ago, 18.years.ago)
  profile.gender = ['Male', 'Female'].sample
  profile.website = Faker::Internet.url
  profile.github_profile = Faker::Internet.url('github.com')
  profile.phone_number = Faker::PhoneNumber.phone_number
  profile.address_line_one = Faker::Address.street_address
  profile.city = Faker::Address.city
  profile.country = Faker::Address.country
  profile.odin_profile_link = Faker::Internet.url('theodinproject.com')
  profile.save
end

User.all.each do |user|
  10.times do
    post = user.posts.new
    post.content = Faker::Lorem.sentence
    post.save
  end
end

50.times do
  user = User.all.sample
  Post.all.sample.likes.create(user: user)
end

User.all.each do |user|
  5.times do
    user2 = User.all.sample
    while user2 == user
      user2 = User.all.sample
    end
    user.friendships.create(friend: user2, accepted: true)
  end
end

Post.all.each do |post|
  5.times do
    user = User.all.sample
    post.comments.create(user: user, content: Faker::Lorem.sentence)
  end
end

user = User.create(
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password"
  )
5.times do
  user2 = User.create(
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password"
  )
  user.friendships.create(friend: user2)
end
