require 'spec_helper'

feature 'As a user I can edit a document' do
  let!(:document) { create :document }
  let!(:title) { Faker::Lorem.sentence }
  let!(:body)  { Faker::Lorem.paragraph }

  before do
    allow(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path
  end

  scenario 'edit document' do
    click_link(document.title)
    click_link('Improve this document')
    fill_in('document_title', with: title)
    fill_in('document_body', with: body)
    click_button('Save')

    document.reload
    expect(document.title).to eq(title)
    expect(document.body).to  eq(body)
    expect(current_path).to eq(document_path(document))
  end
end
