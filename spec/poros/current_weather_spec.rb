require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'can make a current weather poro', :vcr do
    lat = 39.738453
    lon = -104.984853
    data = OpenWeatherService.all_weather(lat, lon)
    current_weather = CurrentWeather.new(data)

    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to be_a(Time)
    expect(current_weather.sunrise).to be_a(Time)
    expect(current_weather.sunset).to be_a(Time)
    expect(current_weather.temperature).to be_a(Float)
    expect(current_weather.feels_like).to be_a(Float)
    expect(current_weather.humidity).to be_an(Integer)
    expect(current_weather.uvi).to be_a(Float)
    expect(current_weather.visibility).to be_an(Integer)
    expect(current_weather.conditions).to be_a(String)
    expect(current_weather.icon).to be_a(String)
  end
end
