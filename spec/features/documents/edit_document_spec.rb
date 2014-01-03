require 'spec_helper'

feature 'Article edition' do
  let!(:document) { create :document }
  let(:title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }
  let(:sentence) { Faker::Lorem.sentence }

  before do
    allow_any_instance_of(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path

    click_link(document.title)
    click_link('Improve this document')
  end

  scenario 'user edits and saves a document' do
    fill_in('document_title', with: title)
    fill_in('wmd-input', with: body)
    click_button('Save')

    document.reload
    expect(document.title).to eq(title)
    expect(document.body).to  eq(body)
    expect(current_path).to eq(document_path(document))
  end

  context 'when the user enters some markdown text as the article body' do
    scenario 'the article body is transformed to html in real time', :js do
      markdown_h3 = '### ' + sentence

      fill_in('wmd-input', with:  markdown_h3)
      find('h3', text: sentence)
    end
  end
end
