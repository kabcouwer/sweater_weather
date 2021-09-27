class ForecastSerializer

  def self.weather(current, daily, hourly)
  { data:
    {
      id: nil,
      type: 'forecast',
      attributes: {
        current_weather: current.serialize,
        daily_weather:
          daily.map do |day|
            day.serialize
          end,
        hourly_weather:
          hourly.map do |hour|
            hour.serialize
          end
      }
    }
  }
  end
end
