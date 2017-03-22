FactoryGirl.define do
  factory :friendship do
    association :user
    association :friend, factory: :user 
    accepted false
  end
end
