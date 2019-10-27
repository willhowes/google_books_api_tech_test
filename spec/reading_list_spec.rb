# frozen_string_literal: true

require 'reading_list'

describe ReadingList do
  before(:each) do
    @reading_list = ReadingList.new
  end

  describe '#run' do
    it 'asks the user for the name of a book to search' do
      expect { @reading_list.run }.to output("Type the name of the book you want to search then hit enter:\n").to_stdout
    end
  end

  describe '#print_search_results' do
    it 'Once user has typed their query and hit enter the resulting list of books is printed' do
      @reading_list.run
      allow(STDIN).to receive(:gets) { 'flowers' }
      expect(@reading_list.print_search_results).to eq("Search results:\n")
    end
  end
end
