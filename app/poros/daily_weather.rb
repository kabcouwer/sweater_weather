class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = (Time.at(data[:dt]))
    @sunrise = Time.at(data[:sunrise])
    @sunset = Time.at(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def serialize
    {
      date: @date.strftime('%F'),
      sunrise: @sunrise.to_s,
      sunset: @sunset.to_s,
      max_temp: @max_temp,
      min_temp: @min_temp,
      conditions: @conditions,
      icon: @icon
    }
  end
end
