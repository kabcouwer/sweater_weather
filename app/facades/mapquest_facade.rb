class MapquestFacade
  def self.coordinates(location)
    response = MapquestService.coordinates(location)
    coord = response[:results].first[:locations].first[:latLng]
    return coord[:lat], coord[:lng]
  end
end
