class LibraryFacade
  def self.book_search(location, quantity)
    data = LibraryService.book_search(location, quantity)
    return data, forecast(location), books(location, quantity)
  end

  def self.forecast(location)
    coord = MapquestFacade.coordinates(location)
    response = OpenWeatherService.all_weather(coord[:lat], coord[:lng])
    Forecast.new(response)
  end

  def self.books(location, quantity)
    response = LibraryService.book_search(location, quantity)
    response[:docs].map { |book| Book.new(book) }
  end
end
