require 'rails_helper'

RSpec.describe Book, :vcr do
  before :each do
    quantity = 3
    location = 'denver, co'
    data = (LibraryService.book_search(location, quantity))[:docs].first
    @book = Book.new(data)
  end

  it 'can make a book poro' do
    expect(@book).to be_a(Book)
    expect(@book.isbn).to be_an(Array)
    expect(@book.title).to be_a(String)
    expect(@book.publisher).to be_an(Array)
  end
end
