require 'spec_helper'

describe DocumentsController do
  context 'As a user I can' do

    let!(:document) { create(:document) }

    it 'create a document' do
      document = Document.new(body: Faker::Lorem.paragraphs)
      post :create, document

      expect(response).to redirect_to(assigns(document))
      expect(Document.count).to be_eq(1)
    end

    it 'edit a document' do
      new_body = Faker::Lorem.paragraphs
      document.body = new_body

      put :update, document
      expect(document.body).to be_eq(new_body)
    end

    it 'see a document' do
      get :show, document
      expect(response).to have_content(document.body)
    end

  end
end
