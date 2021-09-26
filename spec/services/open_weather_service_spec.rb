require 'rails_helper'

RSpec.describe 'Open Weather Service' do
  describe 'all_weather' do
    it 'has weather data; current, hourly, daily', :vcr do
      # {:lat=>39.738453, :lng=>-104.984853}
      lat = 39.738453
      lon = -104.984853

      response = OpenWeatherService.all_weather(lat, lon)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:lat)
      expect(response[:lat]).to eq(39.7385)

      expect(response).to have_key(:lon)
      expect(response[:lon]).to eq(-104.9849)

      expect(response).to have_key(:current)
      expect(response[:current]).to be_a(Hash)

      expect(response).to have_key(:daily)
      expect(response[:daily]).to be_an(Array)
      expect(response[:daily].first).to be_a(Hash)

      expect(response).to have_key(:hourly)
      expect(response[:hourly]).to be_an(Array)
      expect(response[:hourly].first).to be_a(Hash)

      expect(response.has_key?(:minutely)).to eq(false)

      expect(response.has_key?(:alerts)).to eq(false)
    end
  end
end
