class MapquestFacade
  def self.coordinates(location)
    response = MapquestService.coordinates(location)
    response[:results].first[:locations].first[:latLng]
  end
end
