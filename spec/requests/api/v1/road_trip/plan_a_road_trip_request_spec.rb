require 'rails_helper'

RSpec.describe 'user can plan a road trip' do
  before :each do
    @user_1 = User.create!(email: Faker::Internet.email,
                          password: 'password',
                          password_confirmation: 'password')

    @api_key_1 = @user_1.api_keys.first.token

    @headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    # corrent input
    @body_1 = {
      'origin': 'Denver,CO',
      'destination': 'Pueblo,CO',
      'api_key': @api_key_1
    }.to_json
  end

  describe 'happy paths' do
    it 'can login a user' do
      post '/api/v1/road_trip', headers: @headers, params: @body_1

      expect(response.status).to eq(200)

      # result = JSON.parse(response.body, symbolize_names: true)
      #
      # expect(result).to be_a(Hash)
    end
  end

  describe 'sad paths' do
    it 'returns error if sends bad api_key' do
      body = {
        'origin': 'Denver,CO',
        'destination': 'Pueblo,CO',
        'api_key': 'jgn983hy48thw9begh98h4539h4'
      }.to_json

      post '/api/v1/road_trip', headers: @headers, params: body

      expect(response.status).to eq(401)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('Bad credentials')
    end

    it 'returns error if api_key is not sent' do
      body = {
        'origin': 'Denver,CO',
        'destination': 'Pueblo,CO',
      }.to_json

      post '/api/v1/road_trip', headers: @headers, params: body

      expect(response.status).to eq(401)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('Bad credentials')
    end
  end
end
