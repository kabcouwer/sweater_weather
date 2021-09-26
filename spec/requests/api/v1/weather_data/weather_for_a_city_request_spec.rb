require 'rails_helper'

RSpec.describe 'weather data retrieval for a city' do
  describe 'happy paths' do
    it 'gets weather data', :vcr do
      get '/api/v1/forecast?location=denver,co'

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
    end
  end
end
