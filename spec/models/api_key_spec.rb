require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'relationships' do
    it { should belong_to(:bearer) }
  end

  describe 'validations' do
    subject { ApiKey.new(bearer_id: 1, bearer_type: 'User', token: 'lkgsaf') }
    it { should validate_presence_of(:bearer_id) }
    it { should validate_presence_of(:bearer_type) }
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:token) }
  end
end
