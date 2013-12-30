FactoryGirl.define do
  factory :document, class: 'Document' do
    title Faker::Lorem.sentence
    body  Faker::Lorem.paragraphs
  end
end
