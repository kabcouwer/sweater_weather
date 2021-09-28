require 'rails_helper'

RSpec.describe 'user login' do
  before :each do
    user_1 = User.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
  end

  describe 'happy paths' do
    it 'can login a user' do
      post '/api/v1/sessions'
    end
  end
end
