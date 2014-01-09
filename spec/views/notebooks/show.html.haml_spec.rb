require 'spec_helper'

describe 'notebooks/show.html.haml' do
  before do
    @notebook = create(:notebook)
    allow(NotebooksController).to receive(:show).and_return(@notebook)
    controller.request.path_parameters["action"] = "show"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('Improve this notebook')
  end
end
