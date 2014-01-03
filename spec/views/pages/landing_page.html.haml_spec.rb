require 'spec_helper'

describe 'pages/landing_page.html.haml' do
  before do
    allow(PagesController).to receive(:landing_page).and_return(true)
    controller.request.path_parameters["action"] = "index"
  end

  it 'displays info' do
    render

    expect(rendered).to contain('Knowledge base')
    expect(rendered).to include('tangosource.png')
    expect(rendered).to contain('Sign in with your google account')
    expect(rendered).to contain('Sign in')
  end
end
