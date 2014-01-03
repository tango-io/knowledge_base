require 'spec_helper'

describe 'documents/show.html.haml' do
  before do
    @document = create(:document)
    allow(DocumentsController).to receive(:show).and_return(@document)
    controller.request.path_parameters["action"] = "show"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('Improve this document')
  end
end
