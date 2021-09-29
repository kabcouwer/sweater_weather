class OpenWeatherService
  def self.all_weather(lat, lon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'minutely,alerts'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destination_weather(lat, lon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'current,daily,minutely,alerts'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['appid'] = ENV['open_weather_key']
    end
  end
end
