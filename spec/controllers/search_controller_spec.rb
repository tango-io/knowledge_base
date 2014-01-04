require 'spec_helper'

describe SearchController, '#index' do
  context 'when a search by title is performed' do
    let!(:matching_document){ create :document }
    let!(:non_matching_document){ create :document }

    before{ get :index, search: matching_document.title }

    it 'assigns only matching documents' do
      expect(assigns(:documents)).to eq([matching_document])
    end

    it 'doesn\'t assign non-matching documents' do
      expect(assigns(:documents)).to_not include([matching_document])
    end
  end

  context 'when a search by tag is performed' do
    let(:tags){ Faker::Lorem.words(2) }
    let!(:matching_document){ create :document, tag_list: tags[0] }
    let!(:non_matching_document){ create :document, tag_list: tags[1] }

    before{ get :index, tag: matching_document.tag_list[0] }

    it 'assigsn only matching documents' do
      expect(assigns[:documents]).to eq([matching_document])
    end

    it 'doesn\'t assign non-matching documents' do
      expect(assigns(:documents)).to_not include([matching_document])
    end
  end
end

