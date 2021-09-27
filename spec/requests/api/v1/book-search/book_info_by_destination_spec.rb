require 'rails_helper'

RSpec.describe 'book info by destination' do
  describe 'happy paths', :vcr do
    it 'returns book info' do
      get '/api/v1/book-search?location=denver,co&quantity=5'

      expect(response).to be_a(Hash)
    end
  end
end
