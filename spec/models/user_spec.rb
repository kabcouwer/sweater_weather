require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:api_keys) }
  end

  describe 'validations' do
    subject { User.new(email: 'ex@dev.com') }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('email@address.com').for(:email) }
    it { should_not allow_value('foo').for(:email) }

    it { should validate_presence_of(:password) }
  end

  describe 'create_api_key' do
    it 'creates an api key before saving a new user' do
      user_1 = User.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')

      expect(user_1.api_keys.first).to be_an(ApiKey)
      expect(user_1.api_keys.count).to eq(1)
      expect(user_1.api_keys.first.token).to be_a(String)
    end
  end
end
