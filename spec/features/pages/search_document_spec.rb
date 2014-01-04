require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'Search documents' do
  let!(:title) { Faker::Lorem.sentence }
  let!(:document) { create :document, title: title }
  let!(:document2) { create :document }
  let!(:user) do
    create(
      :tango_user,
      image: Faker::Internet.url,
      name: Faker::Name.name
    )
  end

  before do
    login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    visit root_path
  end

  scenario 'As a user I can search a document' do
    fill_in('search', with: title)
    click_button('Search')

    expect(page.body).to include(document.title)
    expect(page.body).to_not include(document2.title)
  end
end
