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

  def self.destination_weather(lat, lon, trip_time)
    response = OpenWeatherService.destination_weather(lat, lon)
    data = response[:hourly][trip_time - 1]
    DestinationWeather.new(data)
  end
end
