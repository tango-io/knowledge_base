require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

def create_popular_tags
  (1..10).map do |i|
    Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
    Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
  end
end

def create_not_popular_tags
  (11..20).map do |i|
    Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
  end
end

feature 'Tags functionality' do
  context 'at the home page' do
    let!(:popular_tags) { Document.popular_tags }

    let!(:user) do
      create(
        :tango_user,
        image: Faker::Internet.url,
        name: Faker::Name.name
      )
    end

    before do
      create_popular_tags
      create_not_popular_tags
      login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    end

    scenario 'user sees the list of the 10 most popular tags' do
      visit root_path
      popular_tags.each do |tag|
        expect(page.body).to include(tag.name)
      end
    end
  end
end
