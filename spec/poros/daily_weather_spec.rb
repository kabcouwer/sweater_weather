require 'rails_helper'

RSpec.describe DailyWeather, :vcr do
  before :each do
    lat = 39.738453
    lon = -104.984853
    data = OpenWeatherService.all_weather(lat, lon)
    daily_weather = data[:daily].first
    @object = DailyWeather.new(daily_weather)
  end

  it 'can make daily weather poros' do
    expect(@object).to be_a(DailyWeather)
    expect(@object.date).to be_a(Time)
    expect(@object.sunrise).to be_a(Time)
    expect(@object.sunset).to be_a(Time)
    expect(@object.max_temp).to be_a(Float)
    expect(@object.min_temp).to be_a(Float)
    expect(@object.conditions).to be_a(String)
    expect(@object.icon).to be_a(String)
  end

  it 'can serialize' do
    result = @object.serialize

    expect(result).to be_a(Hash)

    expect(result).to have_key(:date)
    expect(result).to have_key(:sunrise)
    expect(result).to have_key(:sunset)
    expect(result).to have_key(:sunset)
    expect(result).to have_key(:min_temp)
    expect(result).to have_key(:conditions)
    expect(result).to have_key(:icon)
  end
end
