require 'spec_helper'

def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'Home Page' do
  context 'when a user is logged in' do
    let!(:user){
      FactoryGirl.create(
        :tango_user,
        image: Faker::Internet.url,
        name: Faker::Name.name
      )
    }

    before do
      login_to_google(uid: user.uid, info: { email: user.email })
    end

    scenario 'user sees her picture in the top bar' do
      expect(page).to have_xpath("//img[@src=\"#{user.image}\"]")
    end

    scenario 'user sees her name in the top bar' do
      expect(page).to have_text(user.name)
    end
  end
end
