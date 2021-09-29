require 'rails_helper'

RSpec.describe MapquestFacade, :vcr do
  describe 'coordinates' do
    it 'can find long. and lat.' do
      location = 'denver,co'

      response = MapquestFacade.coordinates(location)

      expect(response).to be_an(Array)
      expect(response.first).to be_a(Float)
      expect(response.second).to be_a(Float)
    end
  end

  describe 'route' do
    it 'can find travel time for route' do
      from = 'Denver,CO'
      to = 'Los Angeles,CA'

      response = MapquestFacade.route(from, to)

      expect(response).to be_a(String)
      expect(response).to_not eq('impossible')
    end

    it 'can returns error if route is not possible' do
      from = 'Denver,CO'
      to = 'London,UK'

      response = MapquestFacade.route(from, to)

      expect(response).to be_a(String)
      expect(response).to eq('impossible')
    end
  end
end
