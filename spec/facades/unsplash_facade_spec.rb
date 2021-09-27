require 'rails_helper'

RSpec.describe UnsplashFacade, :vcr do
  describe 'picture' do
    it 'has image data' do
      location = 'san fransisco, ca'
      response = UnsplashFacade.picture(location)

      expect(response).to be_an(Image)
    end
  end
end
