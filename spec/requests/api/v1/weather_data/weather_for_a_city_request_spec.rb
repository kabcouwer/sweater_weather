require 'rails_helper'

RSpec.describe 'weather data retrieval for a city' do
  describe 'happy paths', :vcr do
    it 'returns weather data' do
      get '/api/v1/forecast?location=denver,co'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data][:type]).to eq('forecast')
      expect(result[:data][:attributes]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:current_weather)
      expect(result[:data][:attributes][:current_weather]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:daily_weather)
      expect(result[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(result[:data][:attributes][:daily_weather].first).to be_a(Hash)
      expect(result[:data][:attributes][:daily_weather].count).to eq(5)


      expect(result[:data][:attributes]).to have_key(:hourly_weather)
      expect(result[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(result[:data][:attributes][:hourly_weather].first).to be_a(Hash)
      expect(result[:data][:attributes][:hourly_weather].count).to eq(8)
    end
  end

  describe 'sad paths' do
    it 'returns bad request status if no location is given' do
      get '/api/v1/forecast?'

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('need city and state')
    end
  end
end
