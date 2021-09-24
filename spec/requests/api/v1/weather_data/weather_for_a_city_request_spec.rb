require 'rails_helper'

RSpec.describe 'weather data retrieval for a city' do
  describe 'happy paths' do
    it 'gets weather data' do
      headers = { "CONTENT_TYPE" => "application/json"}
      location = 'denver,co'
      get '/api/v1/forecast', headers: headers, params: location
    end
  end
end
