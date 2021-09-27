class LibraryFacade
  def self.book_search(location)
    response = LibraryService.book_search(location)
    return forecast(location)
  end

  def self.forecast(location)
    coord = MapquestFacade.coordinates(location)
    response = OpenWeatherService.all_weather(coord[:lat], coord[:lng])
    Forecast.new(response)
  end

  def books(location)
    response = LibraryFacade.book_search(location)
    Book.new(response)
  end
end
