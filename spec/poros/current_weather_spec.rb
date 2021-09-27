require 'rails_helper'

RSpec.describe CurrentWeather, :vcr do
  before :each do
    lat = 39.738453
    lon = -104.984853
    data = OpenWeatherService.all_weather(lat, lon)
    @current_weather = CurrentWeather.new(data)
  end

  it 'can make a current weather poro' do
    expect(@current_weather).to be_a(CurrentWeather)
    expect(@current_weather.datetime).to be_a(Time)
    expect(@current_weather.sunrise).to be_a(Time)
    expect(@current_weather.sunset).to be_a(Time)
    expect(@current_weather.temperature).to be_a(Float)
    expect(@current_weather.feels_like).to be_a(Float)
    expect(@current_weather.humidity).to be_an(Integer)
    expect(@current_weather.uvi).to be_a(Float)
    expect(@current_weather.visibility).to be_an(Integer)
    expect(@current_weather.conditions).to be_a(String)
    expect(@current_weather.icon).to be_a(String)
  end

  it 'can serialize' do
    result = @current_weather.serialize

    expect(result).to be_a(Hash)

    expect(result).to have_key(:datetime)
    expect(result).to have_key(:sunrise)
    expect(result).to have_key(:sunset)
    expect(result).to have_key(:feels_like)
    expect(result).to have_key(:humidity)
    expect(result).to have_key(:uvi)
    expect(result).to have_key(:visibility)
    expect(result).to have_key(:conditions)
    expect(result).to have_key(:icon)
  end
end
