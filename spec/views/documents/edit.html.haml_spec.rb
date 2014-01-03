require 'spec_helper'

describe 'documents/edit.html.haml' do
  before do
    @document = Document.new
    allow(DocumentsController).to receive(:edit).and_return(@document)
    controller.request.path_parameters["action"] = "edit"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('Edit document')
    expect(rendered).to include('Save')
  end
end
