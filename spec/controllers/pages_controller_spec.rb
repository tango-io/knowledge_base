require 'spec_helper'

def login_user
  allow(controller).to receive(:user_signed_in?).and_return(true)
end

describe PagesController, '#index' do
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
      login_user
      get :index
    end

    it 'renders the index view' do
      expect(response).to render_template('index')
    end

    it 'renders the view with application layout' do
      expect(response).to render_template(layout: 'application')
    end
  end

  describe 'Tags' do
    let(:tag){ Faker::Lorem.word }
    let!(:document){ create(:document, tag_list: tag)}

    before do
      login_user
      get :index
    end

    it 'assigns the tags' do
      expect(assigns(:tags)).to eq([tag])
    end
  end


  describe 'Documents' do
    let!(:documents) do
      (1..20).each do
        create :document
      end
    end

    let!(:recent_documents){ Document.order('created_at DESC').limit(10) }

    before do
      login_user
      get :index
    end

    it 'assigns the 10 most recent documents' do
      expect(assigns(:documents)).to match_array(recent_documents)
    end
  end
end
