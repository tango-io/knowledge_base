
require 'spec_helper'

describe 'pages/landing_page.html.haml' do
  before do
    allow(PagesController).to receive(:index).and_return(true)
    controller.request.path_parameters["action"] = "index"
  end

  it 'displays info' do
    render

    expect(rendered).to include('Search')
  end
end
