require 'rails_helper'

RSpec.describe UnsplashFacade, :vcr do
  describe 'picture' do
    it 'has image data' do
      location = 'denver,co'
      response = UnsplashFacade.picture(location)

      expect(response).to be_an(Image)
    end
  end
end
