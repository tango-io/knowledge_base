require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

feature 'Document visualization' do
  let(:sentence) { Faker::Lorem.sentence }
  let(:markdown_h3) { '### ' + sentence }
  let!(:document) { create :document, body: markdown_h3 }
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

  scenario 'user sees a document', :js do
    within('.documents') do
      click_link(document.title)
    end

    find('h3', text: sentence)
  end
end
