require 'rails_helper'

RSpec.describe Forecast, :vcr do
  before :each do
    data = OpenWeatherService.all_weather(39.7, -105)
    @forecast = Forecast.new(data)
  end

  it 'can make a forecast poro' do
    expect(@forecast).to be_a(Forecast)
    expect(@forecast.summary).to be_a(String)
    expect(@forecast.temperature).to be_a(Float)
  end

  it 'can serialize' do
    expect(@forecast.serialize).to be_a(Hash)
    expect(@forecast.serialize).to have_key(:summary)
    expect(@forecast.serialize[:summary]).to be_a(String)
    expect(@forecast.serialize).to have_key(:temperature)
    expect(@forecast.serialize[:temperature]).to be_a(String)
  end
end
