require 'rails_helper'

RSpec.describe LibraryFacade, :vcr do
  before :each do
    quantity = 3
    location = 'denver,co'
    @response = LibraryFacade.book_search(location, quantity)
  end

  describe 'book_search' do
    it 'has book and forecast data' do
      expect(@response).to be_an(Array)
      expect(@response.first).to be_a(Hash)
      expect(@response.second).to be_a(Forecast)
      expect(@response.third).to be_an(Array)
      expect(@response.third).to include(an_instance_of(Book))
    end
  end
end
