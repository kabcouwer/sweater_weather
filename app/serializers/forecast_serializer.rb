class ForecastSerializer
  # include FastJsonapi::ObjectSerializer

  def self.weather(data)
  { data:
    {
      id: nil,
      type: 'forecast',
      attributes: {
        current_weather: {
          datetime: Time.at(data[:current][:dt])
        }
      }
    }
  }
  end
end
