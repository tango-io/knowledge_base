require 'spec_helper'

describe 'documents/new.html.haml' do
  before do
    allow(DocumentsController).to receive(:new).and_return(true)
    controller.request.path_parameters["action"] = "new"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('New document')
    expect(rendered).to contain('Save')
  end
end
