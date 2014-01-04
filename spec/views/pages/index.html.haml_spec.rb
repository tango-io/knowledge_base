
require 'spec_helper'

describe 'pages/index.html.haml' do
  before do
    @documents = Document.all
    allow(PagesController).to receive(:index).and_return(@documents)
    controller.request.path_parameters["action"] = "index"
  end

  it 'displays info' do
    render

    expect(rendered).to include('Search')
  end
end
