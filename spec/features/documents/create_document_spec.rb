require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'As a user I can create a document' do

  let!(:title) { Faker::Lorem.sentence }
  let!(:body)  { Faker::Lorem.paragraph }
  let!(:tags)  { Faker::Lorem.words.join(',') }
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

  scenario 'create document' do
    click_link('Create document')
    fill_in('document_title', with: title)
    fill_in('document_body', with: body)
    fill_in('document_tag_list', with: tags)
    click_button('Save')

    expect(current_path).to eq(document_path(Document.first))
  end

end
