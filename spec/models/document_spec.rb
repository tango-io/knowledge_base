require 'spec_helper'

describe Document do
  context 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
