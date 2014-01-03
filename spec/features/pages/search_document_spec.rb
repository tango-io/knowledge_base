require 'spec_helper'

feature 'As a user I can' do
  let!(:title) { Faker::Lorem.sentence }
  let!(:document) { create :document, title: title }
  let!(:document2) { create :document }

  before do
    allow_any_instance_of(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path
  end

  scenario 'search a document' do
    fill_in('search', with: title)
    click_button('Search')

    expect(page.body).to include(document.title)
    expect(page.body).to_not include(document2.title)
  end
end
