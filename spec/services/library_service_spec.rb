require 'rails_helper'

RSpec.describe LibraryService, :vcr do
  describe 'book_search' do
    it 'can find book info by destination' do
      location = 'denver,co'
      quantity = 3
      response = LibraryService.book_search(location, quantity)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:numFound)
      expect(response[:numFound]).to be_an(Integer)

      expect(response).to have_key(:docs)
      expect(response[:docs]).to be_an(Array)
      expect(response[:docs].count).to eq(quantity)

      book = response[:docs].first

      expect(book).to be_a(Hash)

      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)

      expect(book).to have_key(:isbn)
      expect(book[:isbn]).to be_an(Array)
      expect(book[:isbn].first).to be_a(String)

      expect(book).to have_key(:publisher)
      expect(book[:publisher]).to be_an(Array)
      expect(book[:publisher].first).to be_a(String)
    end
  end
end
