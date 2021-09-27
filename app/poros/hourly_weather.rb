class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.at(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def serialize
    {
      time: @time.strftime('%T'),
      temperature: @temperature,
      conditions: @conditions,
      icon: @icon
    }
  end
end
