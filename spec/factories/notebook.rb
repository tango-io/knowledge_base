FactoryGirl.define do
  factory :notebook do
    name { Faker::Lorem.words.join(',') }
    association :user, factory: :user
  end
end
