require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

feature 'Document search' do
  let!(:title){ Faker::Lorem.sentence }
  let!(:document){ create :document, title: title }
  let!(:document2){ create :document }
  let!(:user){ create :tango_user }

  before do
    login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    visit root_path
  end

  context 'when the user is searching for a document by title' do
    scenario 'user finds the document if it exists' do
      fill_in('search', with: title)
      click_button('Search')

      expect(page).to have_content(document.title)
      expect(page).to_not have_content(document2.title)
    end

    scenario 'user sees the looked title displayed' do
      fill_in('search', with: title)
      click_button('Search')

      find('h5', text: title)
    end
  end
end
