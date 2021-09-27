class OpenWeatherFacade
  def self.all_weather(lat, lon)
    response = OpenWeatherService.all_weather(lat, lon)
    return current(response), daily(response), hourly(response)
  end

  def self.current(response)
    CurrentWeather.new(response)
  end

  def self.daily(response)
    response[:daily].map { |day| DailyWeather.new(day) }
  end

  def self.hourly(response)
    response[:hourly].map { |hour| HourlyWeather.new(hour) }
  end
end
