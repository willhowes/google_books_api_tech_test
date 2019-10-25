require 'httparty'

API_KEY = open('config/.api_key').read()


class BookQuery

  include HTTParty
  format :json
  base_uri "https://www.googleapis.com/books/v1/"

  def initialize(query)
    @query = query
    response
  end

  def response
    self.class.get("/volumes?q=#{@query}&maxResults=5&key=#{API_KEY}")
  end

  def books 
    self.response["items"]
  end

end

google_books = BookQuery.new("Alice in Wonderland")

books = google_books.books

# p books[0]

# books.each_with_index do |book, index| 
#   puts "---BOOK NO: #{index + 1}----\n"
#   p "Title: #{book["volumeInfo"]['title']}"
#   p "Author: #{book["volumeInfo"]['authors']}"
#   p "Publisher: #{book["volumeInfo"]['publisher']}"
#   p "----------------"
# end