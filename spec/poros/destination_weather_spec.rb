require 'rails_helper'

RSpec.describe DestinationWeather, :vcr do
  before :each do
    lat = 34
    lon = 118
    time = 15
    response = OpenWeatherService.destination_weather(lat, lon)
    data = response[:hourly][time - 1]

    @destination_weather = DestinationWeather.new(data)
  end

  it 'can make a destination_weather poro' do
    expect(@destination_weather).to be_a(DestinationWeather)
    expect(@destination_weather.temperature).to be_a(Float)
    expect(@destination_weather.conditions).to be_a(String)
  end

  it 'can serialize' do
    expect(@destination_weather.serialize).to be_a(Hash)

    expect(@destination_weather.serialize).to have_key(:temperature)
    expect(@destination_weather.serialize[:temperature]).to be_a(Float)

    expect(@destination_weather.serialize).to have_key(:conditions)
    expect(@destination_weather.serialize[:conditions]).to be_a(String)
  end
end
