class DestinationWeather
  attr_reader :temperature,
              :conditions

  def initialize(data)
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
  end

  def serialize
    {
      temperature: @temperature,
      conditions: @conditions
    }
  end
end
