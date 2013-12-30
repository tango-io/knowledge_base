include 'spec_helper'

describe DocumentsController do
  context 'As a user I can' do

    let!(document) {build :document}

    it 'create a document' do
      expect(post :create, document).to redirect_to(assigns(document))
      expect{Document.count}.to be_eql(1)
    end

    it 'edit a document' do
      new_body = Faker::Lorem.paragraphs

      document.save!
      document.body = new_body

      put :update, document
      expect(document.body).to be_eql(new_body)
    end

    it 'see a document' do
      document.save!
      get :show, document
      expect(response).to have_content(document.title)
    end

  end
end
