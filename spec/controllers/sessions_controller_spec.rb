require 'spec_helper'
require 'support/oauth_response'

describe SessionsController do
  describe 'POST create' do
    let!(:oauth_reponse) do
      OauthReponse.response
    end

    before do
      controller.request.env['omniauth.auth'] = oauth_reponse
    end

    context 'if the user account is from Tango' do
      context 'if the received user doesn\'t exist in the db' do
        let(:uid){ oauth_reponse['uid'].to_s }
        let(:email ){ oauth_reponse['info']['email'] }
        let(:image){ oauth_reponse['info']['image'] }
        let(:token){ oauth_reponse['credentials']['token'] }

        before{ post :create }

        it 'creates the user' do
          user = User.find_by(uid: uid)

          expect(user.uid).to eq(uid)
          expect(user.email).to eq(email)
          expect(user.image).to eq(image)
          expect(user.token).to eq(token)
        end

        it 'creates a session for the user' do
          id = User.find_by(uid: uid).id
          expect(controller.session['user_id']).to eq(id)
        end

        it 'redirects the user to the root_path' do
          expect(response).to redirect_to(root_path)
        end
      end

      context 'if the received user exists in the db' do
        let!(:user){ FactoryGirl.create :user, uid: oauth_reponse['uid'] }

        before{ post :create }

        it 'creates a session for the user' do
          expect(controller.session['user_id']).to eq(user.id)
        end

        it 'redirects the user to the root_path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end


    context 'if the user account isn\'t from Tango' do
      before do
        oauth_reponse['info']['email'] = "#{Faker::Lorem.word}@notTangosource.com"
        controller.request.env['omniauth.auth'] = oauth_reponse

        post :create
      end

      it 'doesn\'t create the user' do
        expect(User.count).to eq(0)
      end

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
