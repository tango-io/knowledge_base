include 'spec_helper'

describe Document do
  context 'Validations' do
    it should_validates_presence_of(:title)
  end
end
