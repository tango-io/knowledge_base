require 'spec_helper'

feature 'Document visualization' do
  let(:sentence) { Faker::Lorem.sentence }
  let(:markdown_h3) { '### ' + sentence }
  let!(:document) { create :document, body: markdown_h3 }

  before do
    allow_any_instance_of(PagesController).to receive(:user_signed_in?).and_return(true)
    visit root_path
  end

  scenario 'user sees a document', :js do
    within('.documents') do
      click_link(document.title)
    end

    find('h3', text: sentence)
  end
end
