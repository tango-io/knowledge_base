require 'spec_helper'

describe User, 'validations' do
  it { should validate_presence_of   :uid   }
  it { should validate_uniqueness_of :uid   }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of   :token }
end

describe User, 'associations' do
  it { should have_many :notebooks }
end
