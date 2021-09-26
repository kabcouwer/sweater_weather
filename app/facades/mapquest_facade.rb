class MapquestFacade
  def self.coordinates(location)
    response = MapquestService.coordinates(location)
    coord = response[:results].first[:locations].first[:latLng]
    # binding.pry
  end
end
