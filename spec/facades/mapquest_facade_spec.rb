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
end
