require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options
  visit '/auth/google_oauth2'
end

feature 'Notebook edition' do
  let!(:notebook) { create :notebook }
  let(:name) { Faker::Name.name }
  let!(:user) do
    create(
      :tango_user,
      image: Faker::Internet.url,
      name: Faker::Name.name
    )
  end

  before do
    login_to_google(uid: user.uid, info: { email: user.email }, credentials: {})
    visit notebooks_path

    click_link("#edit_#{notebook.id}")
  end

  scenario 'user edits and saves a notebook' do
    fill_in('notebook_name', with: name)
    select('private', :from => 'notebook_type')
    click_button('Save')

    notebook.reload
    expect(notebook.title).to eq(title)
    expect(current_path).to eq(notebooks_path)
    expect(page.body).to include(notebook.name)
  end
end
