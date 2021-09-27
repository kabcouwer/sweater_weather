require 'rails_helper'

RSpec.describe UnsplashService, :vcr do
  describe 'picture' do
    it 'can connect to unsplash service and return a data hash' do
      location = 'denver,co'
      response = UnsplashService.picture(location)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:results)
      expect(response[:results]).to be_an(Array)
      expect(response[:results].first).to have_key(:urls)
      expect(response[:results].first[:urls]).to be_a(Hash)
      expect(response[:results].first[:urls]).to have_key(:regular)
      expect(response[:results].first[:urls][:regular]).to be_a(String)

      expect(response[:results].first).to have_key(:user)
      expect(response[:results].first[:user]).to be_a(Hash)
      expect(response[:results].first[:user]).to have_key(:username)
      expect(response[:results].first[:user][:username]).to be_a(String)

      expect(response[:results].first[:user]).to have_key(:links)
      expect(response[:results].first[:user][:links]).to be_a(Hash)
      expect(response[:results].first[:user][:links]).to have_key(:html)
      expect(response[:results].first[:user][:links][:html]).to be_a(String)
    end
  end
end
