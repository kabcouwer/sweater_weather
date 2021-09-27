require 'rails_helper'

RSpec.describe OpenWeatherFacade, :vcr do
  describe 'all_weather' do
    it 'has weather data' do
      lat = 39.738453
      lon = -104.984853
      response = OpenWeatherFacade.all_weather(lat, lon)

      expect(response).to be_an(Array)
      expect(response.first).to be_a(CurrentWeather)
      expect(response.second).to be_an(Array)
      expect(response.second).to include(an_instance_of(DailyWeather))
      expect(response.third).to be_an(Array)
      expect(response.third).to include(an_instance_of(HourlyWeather))
    end
  end
end
