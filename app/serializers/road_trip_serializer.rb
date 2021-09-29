class RoadTripSerializer
  def self.impossible(from, to, time)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: from,
          end_city: to,
          travel_time: time,
          weather_at_eta: {}
        }
      }
    }
  end

  def self.route(from, to, time, weather)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: from,
          end_city: to,
          travel_time: time,
          weather_at_eta: weather.serialize
        }
      }
    }
  end
end
