class MapquestService
  def self.coordinates(location)
    response = conn.get("/geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['mapquest_key']
    end
  end
end
