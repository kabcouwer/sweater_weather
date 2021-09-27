class ForecastSerializer

  def self.weather(current, daily)
  { data:
    {
      id: nil,
      type: 'forecast',
      attributes: {
        current_weather: {
          datetime: current.datetime,
          sunrise: current.sunrise,
          sunset: current.temperature,
          feels_like: current.feels_like,
          humidity: current.humidity,
          uvi: current.uvi,
          visibility: current.visibility,
          conditions: current.conditions,
          icon: current.icon
        },
        daily_weather:
          daily.map do |day|
            day.serialize
          end
          }
        }
      }
    }
  }
  end
end
