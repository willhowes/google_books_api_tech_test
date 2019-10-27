# frozen_string_literal: true

require 'httparty'

API_KEY = open('config/.api_key').read

class BookQuery
  include HTTParty
  base_uri 'https://www.googleapis.com/books/v1/'

  def initialize(query)
    @query = query
    make_query
  end

  def get_books_list
    @books_list
  end

  def set_books_list(books)
    @books_list = books
  end

  def make_query
    response = self.class.get("/volumes?q=#{@query}&maxResults=5&key=#{API_KEY}")
    books = JSON.parse(response.body)
    add_to_books_list(books['items'])
    books['items']
  end

  private

  def add_to_books_list(books)
    books_list = []
    books.each do |book|
      book = book['volumeInfo']
      book_details = { "title": book['title'],
                       "author": book['authors'].join(','),
                       "publisher": book['publisher'] }
      books_list << book_details
    end
    set_books_list(books_list)
  end
end

# COMMENTED CODE BELOW FOR TESTING AN ACTUAL API RESPONSE NOT STUBBED RESPONSE
# google_books = BookQuery.new("Alice in Wonderland")

# books = google_books.get_books_list

# p books

# books.each_with_index do |book, index|
#   puts "---BOOK NO: #{index + 1}----\n"
#   p "Title: #{book["volumeInfo"]['title']}"
#   p "Author: #{book["volumeInfo"]['authors']}"
#   p "Publisher: #{book["volumeInfo"]['publisher']}"
#   p "----------------"
# end
