class LibraryService
  def self.book_search(location)
    loc = location.gsub(',', '+')
    response = conn.get("/search.json?title=#{loc}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end
end
