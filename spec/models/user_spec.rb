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

describe User do

  let!(:user) { create(:user) }

  context 'notebooks' do

    let!(:notebook) { user.notebooks.first }

    it 'creates a default notebook' do
      expect(notebook).to_not be_nil
    end

    it 'has a default name #{first_name}\'s notebook' do
      expect(notebook.name).to eq("#{user.first_name}'s notebook")
    end
  end

end
