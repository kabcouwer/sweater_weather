require 'rails_helper'

RSpec.describe HourlyWeather do
  before :each do
    lat = 39.738453
    lon = -104.984853
    data = OpenWeatherService.all_weather(lat, lon)
    hourly_weather = data[:hourly].first
    @object = HourlyWeather.new(hourly_weather)
  end

  describe 'hourly_weather', :vcr do
    it 'can make daily weather poros' do
      expect(@object).to be_a(HourlyWeather)
      expect(@object.time).to be_a(Time)
      expect(@object.temperature).to be_a(Float)
      expect(@object.conditions).to be_a(String)
      expect(@object.icon).to be_a(String)
    end

    it 'can serialize' do
      result = @object.serialize

      expect(result).to be_a(Hash)

      expect(result).to have_key(:time)
      expect(result).to have_key(:temperature)
      expect(result).to have_key(:conditions)
      expect(result).to have_key(:icon)
    end
  end
end
