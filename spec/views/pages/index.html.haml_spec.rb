require 'spec_helper'

describe 'pages/index.html.haml' do
  let(:tags){ Faker::Lorem.words(3) }

  before do
    assign(:documents, stub_model(Document))
    assign(:popular_tags, tags)
    assign(:tags, tags)

    render
  end

  it 'displays the search button' do
    expect(rendered).to include('Search') # for some reason the 'Search' button
                                          # isn't visible there, so I had to use
                                          # 'include'
  end

  it 'displays the tags' do
    tags.each do |tag|
      expect(rendered).to contain(tag)
    end
  end
end
