require 'spec_helper'

describe 'notebooks/new.html.haml' do
  before do
    @document = Notebook.new
    allow(NotebooksController).to receive(:new).and_return(@notebook)
    controller.request.path_parameters["action"] = "new"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('New notebook')
    expect(rendered).to include('Save')
  end
end
