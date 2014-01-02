require 'spec_helper'

feature 'As a user I can create a document' do

  let!(:title) { Faker::Lorem.sentence }
  let!(:body)  { Faker::Lorem.paragraph }

  before do
    allow_any_instance_of(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path
  end

  scenario 'create document' do
    click_link('Create document')
    fill_in('document_title', with: title)
    fill_in('document_body', with: body)
    click_button('Save')

    expect(current_path).to eq(document_path(Document.first))
  end
end
