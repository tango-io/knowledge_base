require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'As a user I can see a document' do
  let!(:document) { create :document }
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

  scenario 'show document' do
    within('.documents') do
      click_link(document.title)
    end

    expect(page.body).to have_content(document.body)
  end
end
