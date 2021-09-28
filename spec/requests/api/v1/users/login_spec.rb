require 'rails_helper'

RSpec.describe 'user login' do
  before :each do
    user_1 = User.create!(email: Faker::Internet.email,
                          password: 'password',
                          password_confirmation: 'password')

    @headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    # corrent input
    @user_params_1 = {
      email: User.last.email,
      password: 'password',
    }.to_json
  end

  describe 'happy paths' do
    it 'can login a user' do
      post '/api/v1/sessions', headers: @headers, params: @user_params_1

      expect(response.status).to eq(200)
    end
  end
end
