require 'spec_helper'

describe Document do
  let!(:document) { create :document }

  context 'Validations' do
    it { should validate_presence_of(:title) }
  end

  describe '.search' do
    it 'is able to search documents by title' do
      title = Faker::Lorem.sentence
      document2 = create(:document, title: title)
      expect(Document.search(title)).to include(document2)
    end
  end

  describe '.popular_tags' do
    it 'is able to find the popular tags' do
      (1..10).map do |i|
        Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
        Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
      end

      (11..20).map do |i|
        Document.create( title: Faker::Lorem.sentence, tag_list: i.to_s )
      end

      expect(Document.popular_tags).to eq(
        Document.tag_counts_on(:tags, limit: 10, order: 'count desc')
      )
    end
  end
end
