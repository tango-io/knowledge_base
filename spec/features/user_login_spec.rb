require 'spec_helper'


def login_to_google(mock_options)
  OmniAuth.config.add_mock :google_oauth2, mock_options

  visit '/auth/google_oauth2'
end

feature 'Oauth authentication' do
  before{ visit root_path }

  scenario 'user sees the login button with the right url' do
    expect(page.find_link('Sign in')[:href]).to eq('auth/google_oauth2')
  end

  context 'when clicking on the login button' do
    before do
      OmniAuth.config.add_mock(
        :google_oauth2,
        uid: rand(100),
        info: {
          email: Faker::Internet.email
        }
      )
    end

    scenario 'user is redirected to the omniauth url', :js do
      click_link 'Sign in'

      expect(current_path).to eq('/auth/google_oauth2/callback')
    end
  end

  context 'once the user has been authenticated through google ouath' do
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
