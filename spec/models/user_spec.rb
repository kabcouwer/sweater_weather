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

  describe 'downcase email' do
    it 'can downcase email before saving user to database' do
      user = User.create!(email: 'DEV@ex.com',
                          password: 'password',
                          password_confirmation: 'password')

      expect(user.email).to eq('dev@ex.com')
    end
  end

  describe 'create_api_key' do
    it 'creates an api key before saving a new user' do
      user = User.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')

      expect(user.api_keys.first).to be_an(ApiKey)
      expect(user.api_keys.count).to eq(1)
      expect(user.api_keys.first.token).to be_a(String)
    end
  end

  describe 'get_user_by_api_key' do
    it 'can find user by their api_key' do
      user1 = User.create!(email: Faker::Internet.email,
                           password: 'password',
                           password_confirmation: 'password')
      user2 = User.create!(email: Faker::Internet.email,
                          password: 'other_password',
                          password_confirmation: 'other_password')
      api_key = user1.api_keys.first.token

      expect(User.get_user_by_key(api_key)).to eq(user1)
    end
  end
end
