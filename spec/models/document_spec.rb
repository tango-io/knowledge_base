require 'spec_helper'

describe Document do
  context 'Validations' do
    it { should validate_presence_of(:title) }
  end

  context 'Methods' do
    let!(:document) { create :document }
    it 'search' do
      title = Faker::Lorem.sentence
      document2 = create(:document, title: title)
      expect(Document.search(title)).to include(document2)
    end
  end

end
