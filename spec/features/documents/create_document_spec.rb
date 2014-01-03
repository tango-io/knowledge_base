require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'Article creation' do
  let(:title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }
  let(:sentence) { Faker::Lorem.sentence }
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

    click_link('Create Document')
  end

  scenario 'user saves a new document to the database' do
    fill_in('document_title', with: title)
    fill_in('wmd-input', with: body)
    click_button('Save')

    expect(current_path).to eq(document_path(Document.first))
  end

  context 'when the user enters some markdown text as the article body' do
    scenario 'the article body is transformed to html in real time', :js do
      markdown_h3 = '### ' + sentence

      fill_in('wmd-input', with:  markdown_h3)
      find('h3', text: sentence)
    end
  end
end
