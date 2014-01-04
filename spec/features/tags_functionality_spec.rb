require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

def create_popular_tags(tags)
  (1..10) do |i|
    Document.create()
  end
end

def create_not_popular_tags(tags)
  (11..20) do |i|

  end
end

feature 'Tags functionality' do
  context 'at the home page' do
    let!(:popular_tags){ Faker::Lorem.words(10) }
    let!(:not_popular_tags){ Faker::Lorem.words(10) }
    let!(:user) do
      create(
        :tango_user,
        image: Faker::Internet.url,
        name: Faker::Name.name
      )
    end

    before do
      login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    end

    scenario 'user sees the list of the 10 most popular tags' do
      visit root_path
    end
  end
end
