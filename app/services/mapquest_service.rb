class MapquestService
  def self.coordinates(location)
    res = conn.get("/geocoding/v1/address?location=#{location}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def self.route(from, to)
    res = conn.get("/directions/v2/route?from=#{from}&to=#{to}")
    JSON.parse(res.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['key'] = ENV['mapquest_key']
    end
  end
end
