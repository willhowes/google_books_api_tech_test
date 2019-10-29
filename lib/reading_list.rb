# frozen_string_literal: true

require_relative './book_query.rb'

class ReadingList
  def initialize
    @reading_list = []
  end

  def run
    system "clear"
    main_menu
    user_input = get_user_input
    until valid_menu_option?(user_input)
      puts "Invalid option. Please enter 1, 2 or 3"
      user_input = get_user_input
    end

    case user_input
    when "1"
      query_option
    
    when "2"
      view_reading_list

    when "3"
      exit_program
    end
  end

  def main_menu
    puts "--- WELCOME TO THE READING LIST APP ---\n"\
    "----- MAIN MENU -----\n"\
    "------ Options: ------\n"\
    "1. Search for books\n"\
    "2. View Reading List\n"\
    "3. Exit\n"
  end

  def query_option
    system "clear"
    puts "---- SEARCH FOR BOOKS ----\n"
    puts 'Type the name of the book you want to search then hit enter:'
    query_text = get_user_input
    book_query = make_query(query_text)
    query_results = retreive_query_results(book_query)
    if query_results == "No search results"
      sleep 0.5
      puts "\nNo search result. Please try again..."
      sleep 1.5
      query_option
    end
    puts "\n---------------\nSearch results:\n---------------"
    print_search_result(query_results)
    save_book_option(query_results)
  end

  def save_book_option(query_results)
    puts "If you would like to save a book to your reading list, enter the number and hit return. "\
    "Otherwise please enter 'exit' to return to the main menu "
    book_no_to_save = get_user_input
    
    if book_no_to_save == "exit"
      return_to_menu
    end

    book_no_to_save = book_no_to_save.to_i
    book_list = query_results

    until valid_book_no?(book_no_to_save, book_list)
      puts "Invalid book number please try again:"
      book_no_to_save = get_user_input
      if book_no_to_save == "exit"
        return_to_menu
      end
      book_no_to_save = book_no_to_save.to_i
      book_list = query_results
    end

    puts "Thank you."
    book_to_save = book_list[book_no_to_save -1]
    save_to_reading_list(book_to_save)
    updated_reading_list = get_list
    puts "#{updated_reading_list.last[:title]} saved to your reading list"
    return_to_menu
  end

  def valid_book_no?(book_no, book_list)
    book_no <= book_list.length && book_no > 0
  end

  def valid_yes_no?(user_input)
    user_input == "y" || user_input == "n"
  end

  def valid_menu_option?(user_input)
    user_input == "1" || user_input == "2" || user_input == "3" 
  end

  def make_query(query_text)
    return BookQuery.new(query_text)
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

  def view_reading_list
    system "clear"
    puts "\n--- READING LIST ---\n"
    reading_list = get_list
    if reading_list.empty? 
      puts "There are no book in your reading list currently\n"
      return_to_menu
    end
    reading_list.each_with_index do | book, index |
      puts "#{index +1}. #{book[:title]} | Author: #{book[:author]} | Publisher: #{book[:publisher]}\n"
      puts "\n\nHit enter to return to the main menu\n"
      user_input = $stdin.gets
      if user_input == "\n"
        return_to_menu
      end
    end
  end

  def get_user_input
    $stdin.gets.chomp
  end

  def return_to_menu
    sleep 1
    puts "Returning to main menu..."
    sleep 1
    run
  end

  def exit_program
    puts "Exiting program..."
    sleep 1
    system "clear"
    exit
  end
end

# TO MANUALLY TEST THAT THE A REQUEST TO THE ACTUAL API WORKS
# reading_list = ReadingList.new
# reading_list.run
