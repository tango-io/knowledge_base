require 'spec_helper'

describe DocumentsController do
  context 'As a user I can' do

    let!(:document) { create(:document) }

    it 'create a document' do
      sentence = Faker::Lorem.sentence
      document = { title: sentence }

      post :create, { document: document }

      expect(response).to redirect_to(document_url(Document.last))
      expect(Document.last.title).to eq(sentence)
    end

    it 'edit a document' do
      new_body = Faker::Lorem.paragraph

      put :update, { id: document.id, document: { body: new_body } }
      document.reload
      expect(document.body).to include(new_body)
    end

    it 'see a document' do
      get :show, { id: document.id }
      expect(response.request.fullpath).to eq(document_path(document))
    end

  end
end
