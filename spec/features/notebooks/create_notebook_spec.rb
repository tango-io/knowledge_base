require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'Notebook creation' do
  let!(:name) { Faker::Name.name }
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

    click_link('Create notebook')
  end

  scenario 'user saves a new notebook to the database' do
    fill_in('notebook_name', with: name)
    select('private', :from => 'notebook_type')
    click_button('Save')

    expect(current_path).to eq(notebooks_path)
    expect(user.notebooks.count).to eq(1)
  end
end
