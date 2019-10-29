# frozen_string_literal: true

require 'reading_list'
require 'stringio'

describe ReadingList do
  before(:each) do
    @reading_list = ReadingList.new
    @book_query = double('book_query')
    $stdin = StringIO.new("flowers\n")
    @books_stub = [{ title: '100 Flowers to Knit & Crochet', author: 'Lesley Stanfield', publisher: 'Macmillan' }]
    @books_stub_2 = [{ title: 'Interpretative Phenomenological Analysis', author: 'Jonathan A Smith,Paul Flowers,Michael Larkin', publisher: 'SAGE' }]
  end

  after(:each) do
    $stdin = STDIN
  end

  describe '#run' do
    #(WIP) This test should handle a full user journey 
    xit 'asks the user for the name of a book to search' do
      allow(@reading_list).to receive(:make_query).and_return(@book_query)
      allow(@reading_list).to receive(:retreive_query_results).and_return(@books_stub)
      expect { @reading_list.run }.to output("Type the name of the book you want to search then hit enter:"\
                                              "\n\n---------------\nSearch results:\n---------------\n"\
                                              "1. 100 Flowers to Knit & Crochet\nAuthor: Lesley Stanfield\nPublisher: Macmillan"\
                                              "\n-------------------------------\n").to_stdout
    end
  end

  describe '#save_book_option' do
    xit "Asks user if they want to save a book to their reading list and handles a request with a valid input correctly" do
      $stdin = StringIO.new("1\n")
      expect { @reading_list.save_book_option(@books_stub) }.to output("If you would like to save a book to your reading list, enter the number and hit return."\
                                                      "Otherwise please type 'exit' and hit return\n"\
                                                      "Thank you.\n"\
                                                      "#{@books_stub[0][:title]} saved to your reading list\n").to_stdout
    

    end
  end

  describe "#valid_book_no?" do
    it "returns true if the book no requested is valid" do
      expect(@reading_list.valid_book_no?(1, @books_stub)).to eq(true)
    end

    it "returns false if the book no requested is invalid" do
      expect(@reading_list.valid_book_no?(2, @books_stub)).to eq(false)
    end
  end

  describe "#valid_yes_no?" do
    it "returns true for a input of 'y' or 'n'" do
      expect(@reading_list.valid_yes_no?('y')).to eq(true)
      expect(@reading_list.valid_yes_no?('n')).to eq(true)
    end

    it "returns false for anything other than 'y' or 'n'" do
      expect(@reading_list.valid_yes_no?("")).to eq(false)
      expect(@reading_list.valid_yes_no?("1")).to eq(false)
      expect(@reading_list.valid_yes_no?("t")).to eq(false)
    end
  end

  describe '#save_to_reading_list' do
    it 'saves a given book to the reading list' do
      @reading_list.save_to_reading_list(@books_stub[0])
      expect(@reading_list.get_list).to eq([{ title: '100 Flowers to Knit & Crochet',
                                              author: 'Lesley Stanfield',
                                              publisher: 'Macmillan' }])
    end

    it 'can save more than one book to the reading list' do
      @reading_list.save_to_reading_list(@books_stub[0])
      @reading_list.save_to_reading_list(@books_stub_2[0])
      expect(@reading_list.get_list).to eq([{ title: '100 Flowers to Knit & Crochet',
                                              author: 'Lesley Stanfield',
                                              publisher: 'Macmillan' },
                                            { title: 'Interpretative Phenomenological Analysis',
                                              author: 'Jonathan A Smith,Paul Flowers,Michael Larkin',
                                              publisher: 'SAGE' }])
    end
  end

  describe "#main_menu" do
    it("Has a helpful welcome message with the users options") do
      expect { @reading_list.main_menu }.to output("--- WELCOME TO THE READING LIST APP ---\n"\
                                              "----- MAIN MENU -----\n"\
                                              "------ Options: ------\n"\
                                              "1. Search for books\n"\
                                              "2. View Reading List\n"\
                                              "3. Exit\n").to_stdout
    end
  end

  describe "#view_reading_list" do
    it("has a helpful message if no books have been added to the list") do
      expect { @reading_list.view_reading_list }.to output("There are no book in your reading list currently\n").to_stdout
    end

    it("displays the reading list if there is one to display") do
      allow(@reading_list).to receive(:get_list).and_return([{ title: '100 Flowers to Knit & Crochet', author: 'Lesley Stanfield', publisher: 'Macmillan' }])
      expect { @reading_list.view_reading_list }.to output("\n--- READING LIST ---\n"\
                                                            "1. 100 Flowers to Knit & Crochet | Author: Lesley Stanfield | Publisher: Macmillan\n"\
                                                            "\n\nHit enter to return to the main menu\n").to_stdout

    end
  end

  describe ('#valid menu option') do
    it("returns true if 1, 2 or 3 is given") do
      expect(@reading_list.valid_menu_option?("1")).to eq(true)
      expect(@reading_list.valid_menu_option?("2")).to eq(true)
      expect(@reading_list.valid_menu_option?("3")).to eq(true)
    end
    it("returns false if anything other than 1, 2 or 3 is given") do
      expect(@reading_list.valid_menu_option?("")).to eq(false)
      expect(@reading_list.valid_menu_option?("e")).to eq(false)
      expect(@reading_list.valid_menu_option?("4")).to eq(false)
    end
  end

  describe "#exit_program" do
    it("Has a helpful message to tell user the program is quiting") do
      expect{ @reading_list.exit_program }.to output("Exiting program...").to_stdout
    end
  end
end
