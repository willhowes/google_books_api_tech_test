require 'book_query'

describe 'BookQuery' do
  before(:each) do
    @book_query = BookQuery.new("Test")
  end

  describe '#books' do
    it 'returns the books from the API response' do
      books = @book_query.books
      expect(books[0]["volumeInfo"]["title"]).to eq("100 Flowers to Knit & Crochet")    
    end
  end
end