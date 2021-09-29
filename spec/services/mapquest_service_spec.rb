require 'rails_helper'

RSpec.describe MapquestService, :vcr do
  describe 'coordinates' do
    it 'can find long. and lat.' do
      location = 'denver,co'

      response = MapquestService.coordinates(location)

      expect(response).to be_a(Hash)

      result = response[:results].first[:locations].first[:latLng]

      expect(result).to be_a(Hash)

      expect(result).to have_key(:lat)
      expect(result[:lat]).to be_a(Float)

      expect(result).to have_key(:lng)
      expect(result[:lng]).to be_a(Float)
    end
  end

  describe 'route' do
    it 'can find route if it exists' do
      from = 'Denver,CO'
      to = 'Los Angeles,CA'

      response = MapquestService.route(from, to)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:route)

      expect(response[:route]).to be_a(Hash)
      expect(response[:route]).to have_key(:formattedTime)
      expect(response[:route][:formattedTime]).to be_a(String)

      expect(response[:route]).to have_key(:routeError)
      expect(response[:route][:routeError]).to be_a(Hash)

      expect(response[:route][:routeError]).to have_key(:errorCode)
      expect(response[:route][:routeError][:errorCode]).to eq(-400)
    end

    it 'can returns error if route does not exist' do
      from = 'Denver,CO'
      to = 'Paris,FR'

      response = MapquestService.route(from, to)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:route)

      expect(response[:route]).to be_a(Hash)
      expect(response[:route][:routeError]).to have_key(:errorCode)
      expect(response[:route][:routeError][:errorCode]).to eq(2)
    end
  end
end
