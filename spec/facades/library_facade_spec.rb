require 'rails_helper'

RSpec.describe LibraryFacade, :vcr do
  describe 'forecast' do
    it 'can return forcase info' do
      location = 'denver,co'

      response = self.forecast(location)

      expect(response).to be_a(Forecast)
    end
  end
end
