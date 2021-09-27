class LibraryFacade
  def self.book_search(location)
    response = LibraryService.book_search(location)
  end

  def self.forecast(location)
    coord = MapQuestFacade.coordinates(location)
    response = OpenWeatherService.all_weather(coord[:lat], coord[:lng])
    Forecast.new(response)
  end
end
