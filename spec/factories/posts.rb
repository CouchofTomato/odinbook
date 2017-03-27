FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.sentence }
    association :user
  end
end
