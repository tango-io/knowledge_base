FactoryGirl.define do
  factory :document do
    title Faker::Lorem.sentence
    body  Faker::Lorem.paragraphs
  end
end
