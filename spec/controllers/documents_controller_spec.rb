require 'spec_helper'

describe DocumentsController do
  context 'As a user I can' do

    let!(:document) { create(:document) }
    let!(:title) { Faker::Lorem.sentence }
    let!(:body)  { Faker::Lorem.paragraph }
    let!(:tags)  { Faker::Lorem.words.join(',') }

    it 'create a document' do
      document = { 
        title: title,
        body: body,
        tag_list: tags
      }

      post :create, { document: document }

      document = Document.last
      expect(response).to redirect_to(document_url(document))
      expect(document.title).to eq(title)
      expect(document.body).to eq(body)
      expect(document.tag_list.join(',')).to eq(tags)
    end

    it 'edit a document' do
      put :update, { id: document.id, document: { body: body, tag_list: tags } }
      document.reload
      expect(document.body).to include(body)
      expect(document.tag_list.join(',')).to include(tags)
    end

    it 'see a document' do
      get :show, { id: document.id }
      expect(response.request.fullpath).to eq(document_path(document))
    end

    it 'delete a document' do
      delete :destroy, { id: document.id }
      expect(Document.count).to eq(0)
    end

    it 'show message if cannot delete the document' do
      allow_any_instance_of(Document).to receive(:destroy).and_return(false)
      delete :destroy, { id: document.id }

      expect(Document.count).to eq(1)
      expect(flash[:alert]).to eq('Error while deleting document!')
    end

  end
end
