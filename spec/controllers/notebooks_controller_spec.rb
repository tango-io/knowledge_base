require 'spec_helper'

describe NotebooksController do
  context 'As a user I should create a notebook' do
    let!(:notebook) { build(:notebook) }

    it 'create a notebook' do
      post :create, { notebook: notebook }
      expect(response).to redirect_to(notebooks_path)
      expect(Notebook.count).to eq(1)
    end

    it 'not create a notebook' do
      notebook.type = nil
      post :create, { notebook: notebook }
      expect(response).to redirect_to(new_notebook_path)
      expect(flash[:alert]).to eq('Something went wrong, the document was not created!')
      expect(Notebook.count).to eq(0)
    end
  end
end
