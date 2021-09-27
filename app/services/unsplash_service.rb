class UnsplashService
  def self.picture(location)
    response = conn.get("/search/photos?query=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['client_id'] = ENV['unsplash_access_key']
    end
  end
end
