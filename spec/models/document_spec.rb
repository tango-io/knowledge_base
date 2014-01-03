require 'spec_helper'

describe Document do
  context 'Validations' do
    it { should validate_presence_of(:title) }
  end

  context 'Methods' do
    let!(:document) { create :document }
    it 'search_by_title' do
      title = Faker::Lorem.sentence
      document2 = create(:document, title)
      expect(Document.search_by_title).to include(document2)
    end
  end

end
