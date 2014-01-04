require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

feature 'Tagging' do
  let(:tags){ Faker::Lorem.words(2) }
  let!(:document_a){ create(:document, tag_list: tags[0]) }
  let!(:document_b){ create(:document, tag_list: tags[1]) }
  let!(:user){ create :tango_user }

  before do
    login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})

    visit root_path
    click_link tags[0]
  end

  context 'when the user clicks on a tag' do
    scenario 'user sees the documents corresponding to that tag' do
      expect(page).to have_content(document_a.title)
    end

    scenario 'user doesn\'t see tags that doesn\'t correspond to that tag' do
      expect(page).to_not have_content(document_b.title)
    end

    scenario 'user sees the looked tag displayed' do
      find('h5', text: tags[0])
    end
  end
end
