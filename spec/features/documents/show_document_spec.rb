require 'spec_helper'

feature 'As a user I can see a document' do
  let!(document) { create :document }

  background { visit root_path }

  scenario 'show document' do
    click_link(document.title)

    expect(page.body).to have_content(document.body)
  end
end
