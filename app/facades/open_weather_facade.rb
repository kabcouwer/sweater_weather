class OpenWeatherFacade
  def self.all_weather(lat, lon)
    OpenWeatherService.all_weather(lat, lon)
  end
end
