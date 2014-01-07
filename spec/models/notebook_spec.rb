require 'spec_helper'

describe Notebook, 'associations' do
  it { should belong_to(:user)      }
  it { should have_many(:documents) }
end

describe Notebook, 'validations' do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
end
