require 'spec_helper'

feature 'Omniauth user identification' do
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
end


feature 'User login' do
  context 'once the user finished the omniauth authentication process' do
    context 'when the authentication wasn\'t successful' do
      pending
    end

    context 'when the authentication was successful' do
      pending
    end
  end
end
