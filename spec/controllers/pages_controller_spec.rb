require 'spec_helper'

describe PagesController, 'index template' do
  before do
    allow(User).to receive(:find).and_return(nil)
  end

  context 'if there is no user session active' do
    before do
      session[:user_id] = nil
      get :index
    end

    it 'renders the landing_page view' do
      expect(response).to render_template('landing_page')
    end

    it 'renders the view with welcome layout' do
      expect(response).to render_template(layout: 'welcome')
    end
  end

  context 'if there is a user session active' do
    before do
      session[:user_id] = rand(100)
      get :index
    end

    it 'renders the index view' do
      expect(response).to render_template('index')
    end

    it 'renders the view with application layout' do
      expect(response).to render_template(layout: 'application')
    end
  end
end
