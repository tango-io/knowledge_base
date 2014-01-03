require 'spec_helper'

describe 'documents/new.html.haml' do
  before do
    @document = Document.new
    allow(DocumentsController).to receive(:new).and_return(@document)
    controller.request.path_parameters["action"] = "new"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('New document')
    expect(rendered).to include('Save')
  end
end
