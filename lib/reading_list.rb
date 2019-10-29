# frozen_string_literal: true

require_relative './book_query.rb'

class ReadingList
  def initialize
    @reading_list = []
  end

  def main_menu
    puts "--- WELCOME TO THE READING LIST APP ---\n"\
    "----- MAIN MENU -----\n"\
    "------ Options: ------\n"\
    "1. Search for books\n"\
    "2. View Reading List\n"
    "3. Exit\n"
  end

  def run
    puts 'Type the name of the book you want to search then hit enter:'
    query_text = get_user_input
    book_query = make_query(query_text)
    query_results = retreive_query_results(book_query)
    puts "\n---------------\nSearch results:\n---------------"
    print_search_result(query_results)
    save_book_option(query_results)
  end

  def save_book_option(query_results)
    puts "If you would like to save a book to your reading list, enter the number and hit return. "\
    "Otherwise please type 'exit' and hit return"
    book_no_to_save = get_user_input
    book_no_to_save = book_no_to_save.to_i
    book_list = query_results

    until valid_book_no?(book_no_to_save, book_list)
      puts "Invalid book number please try again:"
      book_no_to_save = get_user_input
      book_no_to_save = book_no_to_save.to_i
      book_list = query_results
    end

    puts "Thank you."
    book_to_save = book_list[book_no_to_save -1]
    save_to_reading_list(book_to_save)
    updated_reading_list = get_list
    puts "#{updated_reading_list.last[:title]} saved to your reading list"
    puts "Would you like to add another book to your list? (y/n)"
    yes_no_input = get_user_input.downcase()
    until valid_yes_no?(yes_no_input)
      puts "Invalid option, please type 'y' for yes or 'n' for no:"
      yes_no_input = get_user_input.downcase()
    end
    if yes_no_input == "y"
      save_book_option(query_results)
    end
    if yes_no_input == "n"
      sleep 1
      puts "\nreturning to main menu...\n"
      sleep 1
      main_menu
    end  
  end

  def valid_book_no?(book_no, book_list)
    book_no <= book_list.length && book_no > 0
  end

  def valid_yes_no?(user_input)
    user_input == "y" || user_input == "n"
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

  def get_user_input
    $stdin.gets.chomp
  end
end

# TO MANUALLY TEST THAT THE A REQUEST TO THE ACTUAL API WORKS
# reading_list = ReadingList.new
# reading_list.run
