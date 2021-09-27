require 'rails_helper'

RSpec.describe MapquestFacade, :vcr do
  describe 'coordinates' do
    it 'can find long. and lat.' do
      location = 'denver,co'

      response = MapquestFacade.coordinates(location)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:lat)
      expect(response[:lat]).to be_a(Float)

      expect(response).to have_key(:lng)
      expect(response[:lng]).to be_a(Float)
    end
  end
end
