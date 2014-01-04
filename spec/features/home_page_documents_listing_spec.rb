require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

feature 'List documents' do
  let!(:documents) do
    (1..20).each do
      create :document
    end
  end

  let!(:recent_documents){ Document.order('created_at DESC').limit(10) }
  let!(:non_recent_document){ Document.order('created_at').first }

  let!(:user){ create :tango_user }

  before do
    login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    visit root_path
  end

  scenario 'user sees the 10 most recent documents' do
    recent_documents.each do |document|
      expect(page).to have_content(document.title)
    end
  end

  scenario 'user doesn\'t see non-recent documents' do
    expect(page).to_not have_content(non_recent_document.title)
  end
end
