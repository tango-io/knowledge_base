FactoryGirl.define do
  factory :user do
    uid        { rand(10000)            }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name  }
    token      { Faker::Code.isbn       }
    email      { Faker::Internet.email  }
    image      { Faker::Internet.url    }
  end

  factory :tango_user, parent: :user do
    email { "#{Faker::Lorem.word}@tangosource.com" }
  end
end
