# frozen_string_literal: true

require_relative './book_query.rb'

class ReadingList
  def initialize
    @reading_list = []
  end

  def run
    puts 'Type the name of the book you want to search then hit enter:'
    query_text = $stdin.gets.chomp
    book_query = make_query(query_text)
    query_results = retreive_query_results(book_query)
    puts "\n---------------\nSearch results:\n---------------"
    print_search_result(query_results)
  end

  def make_query(query_text)
    BookQuery.new(query_text)
  end

  def retreive_query_results(book_query)
    book_query.get_books_list
  end

  def print_search_result(books)
    books.each_with_index do |book, index|
      print "#{index + 1}. #{book[:title]}\nAuthor: #{book[:author]}\nPublisher: #{book[:publisher]}\n-------------------------------\n"
    end
  end

  def get_list
    @reading_list
  end

  def set_list(reading_list)
    @reading_list = reading_list
  end

  def save_to_reading_list(book)
    @reading_list << book
  end
end

# TO MANUALLY TEST THAT THE A REQUEST TO THE ACTUAL API WORKS
# reading_list = ReadingList.new
# reading_list.run
