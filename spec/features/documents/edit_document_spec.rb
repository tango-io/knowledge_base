require 'spec_helper'

feature 'As a user I can edit a document' do
  let!(document) { create :document }
  let!(title) { Faker::Lorem.sentence }
  let!(body)  { Faker::Lorem.paragraphs }

  background { visit root_path }

  scenario 'edit document' do
    click_link(document.title)
    click_link('Improve this document')
    fill_in('title', with: title)
    fill_in('body', with: body)
    click_button('Save')

    expect(document.title).to be_eq(title)
    expect(document.body).to  be_eq(body)
    expect(current_path).to be_eq(documents_path(document))
  end
end
