class Api::V1::BookSearchController < ApplicationController
  def index
    if num = params[:quantity].to_i > 0
      data, forecast, books = LibraryFacade.book_search(params[:location], params[:quantity])

      render json: BookForcastSerializer.info(data, forecast, books)
    else
      render json: {error: 'quantity must be greater than zero'}, status: :bad_request
    end
  end
end
