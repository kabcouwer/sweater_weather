require 'rails_helper'

RSpec.describe 'background image for weather page', :vcr do
  describe 'happy paths' do
    it 'can return background image' do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('image')

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:image)
    end
  end

  describe 'sad paths' do
    it 'returns bad request status if location not given' do
      get '/api/v1/backgrounds?location='

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to eq('City and state is required')
    end

    it 'returns bad request status if location not given' do
      get '/api/v1/backgrounds?'

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors]).to eq('City and state is required')
    end
  end
end
