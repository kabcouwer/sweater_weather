class OpenWeatherFacade
  def self.all_weather(lat, lon)
    response = OpenWeatherService.all_weather(lat, lon)
    return current(response), daily(response)
  end

  def self.current(response)
    CurrentWeather.new(response)
  end

  def self.daily(response)
    response[:daily].map { |data| DailyWeather.new(data) }
  end

  def self.hourly(response)
    response[:hourly].map { |data| HourlyWeather.new(data) }
  end
end
