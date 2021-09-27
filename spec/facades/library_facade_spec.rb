require 'rails_helper'

RSpec.describe LibraryFacade, :vcr do
  before :each do
    @quantity = 3
    @location = 'denver,co'
  end

  describe 'forecast' do
    it 'can return forcase info' do
      response = LibraryFacade.forecast(@location)

      expect(response).to be_a(Forecast)
    end
  end

  describe 'books' do
    it 'can return book info' do
      response = LibraryFacade.books(@location, @quantity)

      expect(response).to be_an(Array)
      expect(response.count).to eq(@quantity)
      expect(response).to include(an_instance_of(Book))
    end
  end
end
