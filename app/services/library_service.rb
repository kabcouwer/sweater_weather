class LibraryService
  def self.book_search(location, quantity)
    loc = location.gsub(',', '+')
    response = conn.get("/search.json?q=#{loc}&limit=#{quantity}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://openlibrary.org')
  end
end
