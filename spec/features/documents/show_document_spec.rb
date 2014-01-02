require 'spec_helper'

feature 'As a user I can see a document' do
  let!(:document) { create :document }

  before do
    @documents = Document.all
    allow_any_instance_of(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path
  end

  scenario 'show document' do
    within('.documents') do
      click_link(document.title)
    end

    expect(page.body).to have_content(document.body)
  end
end
