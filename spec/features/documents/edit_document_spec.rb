require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'As a user I can edit a document' do
  let!(:document) { create :document }
  let!(:title) { Faker::Lorem.sentence }
  let!(:body)  { Faker::Lorem.paragraph }
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

  scenario 'edit document' do
    click_link(document.title)
    click_link('Improve this document')
    fill_in('document_title', with: title)
    fill_in('document_body', with: body)
    click_button('Save')

    document.reload
    expect(document.title).to eq(title)
    expect(document.body).to  eq(body)
    expect(current_path).to eq(document_path(document))
  end
end
