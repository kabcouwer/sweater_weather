require 'rails_helper'

RSpec.describe 'user can plan a road trip', :vcr do
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

    # impossible route
    @body_2 = {
      'origin': 'Denver,CO',
      'destination': 'Paris,FR',
      'api_key': @api_key_1
    }.to_json
  end

  describe 'happy paths' do
    it 'returns road trip data if route is possible' do
      post '/api/v1/road_trip', headers: @headers, params: @body_1

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('roadtrip')

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:start_city)
      expect(result[:data][:attributes][:start_city]).to be_a(String)

      expect(result[:data][:attributes]).to have_key(:end_city)
      expect(result[:data][:attributes][:end_city]).to be_a(String)

      expect(result[:data][:attributes]).to have_key(:travel_time)
      expect(result[:data][:attributes][:travel_time]).to be_a(String)
      expect(result[:data][:attributes][:travel_time]).to_not eq('impossible')

      expect(result[:data][:attributes]).to have_key(:weather_at_eta)
      expect(result[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(result[:data][:attributes][:weather_at_eta].empty?).to eq(false)

      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(result[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(result[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end

    it 'returns impossible road trip json if route is not possible' do
      post '/api/v1/road_trip', headers: @headers, params: @body_2

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('roadtrip')

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:start_city)
      expect(result[:data][:attributes][:start_city]).to be_a(String)

      expect(result[:data][:attributes]).to have_key(:end_city)
      expect(result[:data][:attributes][:end_city]).to be_a(String)

      expect(result[:data][:attributes]).to have_key(:travel_time)
      expect(result[:data][:attributes][:travel_time]).to be_a(String)
      expect(result[:data][:attributes][:travel_time]).to eq('impossible')

      expect(result[:data][:attributes]).to have_key(:weather_at_eta)
      expect(result[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(result[:data][:attributes][:weather_at_eta].empty?).to eq(true)
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
