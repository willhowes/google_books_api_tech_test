# frozen_string_literal: true

require_relative './book_query.rb'

class ReadingList
  def run
    puts 'Type the name of the book you want to search then hit enter:'
    query_text = gets.chomp
    book_query = BookQuery.new(query_text)
    query_results = book_query.get_books_list
    print_search_result(query_results)
  end

  def print_search_result(books)
    puts "\n"
    puts '---------------'
    puts 'Search results:'
    puts '---------------'
    books.each_with_index do |book, index|
      puts "#{index + 1}. #{book[:title]} "
      puts "Author: #{book[:author]}"
      puts "Publisher: #{book[:publisher]}"
      puts '-------------------------------'
    end
  end
end

# TO MANUALLY TEST THAT THE A REQUEST TO THE ACTUAL API WORKS
# reading_list = ReadingList.new
# reading_list.run
