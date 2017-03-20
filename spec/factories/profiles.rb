FactoryGirl.define do
  factory :profile do
    association :user
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    date_of_birth { Faker::Date.between(50.years.ago, 18.years.ago) }
    gender 'Male'
    website { Faker::Internet.url }
    github_profile { Faker::Internet.url('github.com') }
    phone_number { Faker::PhoneNumber.phone_number }
    address_line_one { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    odin_profile_link { Faker::Internet.url('theodinproject.com') }
  end
end
