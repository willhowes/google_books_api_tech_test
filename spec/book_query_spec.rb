# frozen_string_literal: true

require 'book_query'

describe BookQuery do
  before(:each) do
    @book_query = BookQuery.new('Test')
  end

  describe '#make_query' do
    it 'returns the books from the API response' do
      query = @book_query.make_query
      expect(query[0]['volumeInfo']['title']).to eq('100 Flowers to Knit & Crochet')
    end
  end

  describe '#get_books_list' do
    it 'returns a list of books' do
      books_list = @book_query.get_books_list
      expect(books_list[0]).to eq("title": '100 Flowers to Knit & Crochet',
                                  "author": 'Lesley Stanfield',
                                  "publisher": 'Macmillan')
    end
  end
end
