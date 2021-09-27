class LibraryFacade
  def self.book_search(location, quantity)
    data = LibraryService.book_search(location, quantity)
    return data, forecast(location), books(data)
  end

  def self.forecast(location)
    coord = MapquestFacade.coordinates(location)
    response = OpenWeatherService.all_weather(coord[:lat], coord[:lng])
    Forecast.new(response)
  end

  def self.books(data)
    data[:docs].map { |book| Book.new(book) }
  end
end
