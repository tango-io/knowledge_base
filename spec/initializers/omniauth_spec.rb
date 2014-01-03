require 'spec_helper'

describe 'Google credentials' do
  describe 'google key' do
    it 'is set' do
      expect(GOOGLE_CREDENTIALS['google_key']).to_not be_nil
    end
  end

  describe 'google secret' do
    it 'is set' do
      expect(GOOGLE_CREDENTIALS['google_secret']).to_not be_nil
    end
  end
end
