class BookForcastSerializer
  def self.info(data, forecast, books)
    { data:
      {
        id: nil,
        type: 'books',
        attributes: {
          destination: data[:q],
          forecast: forecast.serialize,
          total_books_found: data[:num_found],
          books: books.map do |book|
            book.serialize
          end
        }
      }
    }
  end
end
