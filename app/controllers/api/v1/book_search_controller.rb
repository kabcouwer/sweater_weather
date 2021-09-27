class Api::V1::BookSearchController < ApplicationController
  def index
    # binding.pry
    data, forecast, books = LibraryFacade.book_search(params[:location], params[:quantity])
    BookForcastSerializer.info(data, forecast, books)
  end
end
