require 'spec_helper'

describe 'notebooks/edit.html.haml' do
  before do
    @notebook = Notebook.new
    allow(NotebooksController).to receive(:edit).and_return(@notebook)
    controller.request.path_parameters["action"] = "edit"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('Edit notebook')
    expect(rendered).to include('Save')
  end
end
