require 'rails_helper'

RSpec.describe 'book info by destination' do
  describe 'happy paths', :vcr do
    it 'returns book info' do
      get '/api/v1/book-search?location=denver,co&quantity=5'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)

      expect(result).to have_key(:data)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('books')

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('books')

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:destination)
      expect(result[:data][:attributes][:destination]).to eq('denver co')

      expect(result[:data][:attributes]).to have_key(:forecast)
      expect(result[:data][:attributes][:forecast]).to be_a(Hash)

      expect(result[:data][:attributes][:forecast]).to have_key(:summary)
      expect(result[:data][:attributes][:forecast][:summary]).to be_a(String)

      expect(result[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(result[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(result[:data][:attributes]).to have_key(:total_books_found)
      expect(result[:data][:attributes][:total_books_found]).to be_an(Integer)

      expect(result[:data][:attributes]).to have_key(:books)
      expect(result[:data][:attributes][:books]).to be_an(Array)

      expect(result[:data][:attributes][:books].first).to be_a(Hash)

      expect(result[:data][:attributes][:books].first).to have_key(:isbn)
      expect(result[:data][:attributes][:books].first[:isbn]).to be_an(Array)

      expect(result[:data][:attributes][:books].first).to have_key(:title)
      expect(result[:data][:attributes][:books].first[:title]).to be_a(String)

      expect(result[:data][:attributes][:books].first).to have_key(:publisher)
      expect(result[:data][:attributes][:books].first[:publisher]).to be_an(Array)
    end
  end

  describe 'sad paths' do
    it 'returns bad request if quantity is 0' do
      get '/api/v1/book-search?location=denver,co&quantity=0'

      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:error]).to eq('quantity must be greater than zero')
    end
  end
end
