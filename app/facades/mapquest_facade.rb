class MapquestFacade
  def self.coordinates(location)
    response = MapquestService.coordinates(location)
    coord = response[:results].first[:locations].first[:latLng]
    return coord[:lat], coord[:lng]
  end

  def self.route(from, to)
    response = MapquestService.route(from, to)

    if response[:route][:routeError][:errorCode] == -400
      response[:route][:formattedTime]
    else
      return 'impossible'
    end
  end
end
