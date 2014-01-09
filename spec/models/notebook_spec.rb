require 'spec_helper'

describe Notebook, 'validations.' do
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user) }
end
