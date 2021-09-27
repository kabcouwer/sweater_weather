require 'rails_helper'

RSpec.describe 'Open Weather Facade' do
  describe 'all_weather' do
    xit 'has weather data', :vcr do
      lat = 39.738453
      lon = -104.984853

      response = OpenWeatherFacade.all_weather(lat, lon)
      expect(response).to be_a(CurrentWeather)
    end
  end
end
