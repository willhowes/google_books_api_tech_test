require 'httparty'

API_KEY = open('config/.api_key').read()


class BookQuery

  include HTTParty
  base_uri "https://www.googleapis.com/books/v1/"

  def initialize(query)
    @query = query
  end

  def books
    response = self.class.get("/volumes?q=#{@query}&maxResults=5&key=#{API_KEY}")
    books = JSON.parse(response.body)
    return books["items"]
  end

end

## COMMENTED CODE BELOW FOR TESTING AN ACTUAL API RESPONSE NOT STUBBED RESPONSE 
# google_books = BookQuery.new("Alice in Wonderland")

# books = google_books.books

# books.each_with_index do |book, index| 
#   puts "---BOOK NO: #{index + 1}----\n"
#   p "Title: #{book["volumeInfo"]['title']}"
#   p "Author: #{book["volumeInfo"]['authors']}"
#   p "Publisher: #{book["volumeInfo"]['publisher']}"
#   p "----------------"
# end