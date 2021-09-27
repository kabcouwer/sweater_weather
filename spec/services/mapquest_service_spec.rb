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
end
