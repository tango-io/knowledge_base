require 'spec_helper'

feature 'As a user I can create a document' do
  before do
    @title = Faker::Lorem.sentence
    @body  = Faker::Lorem.paragraphs

    visit "/"
  end
  scenario 'create document' do
    click_button('Create document')
    fill_in('title', with: @title)
    fill_in('body', with: @body)
    click_button('Save')

    expect(Document.count).to be_eql(1)
    expect(current_path).to be_eql(document_path(Document.first))
  end
end
