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
    it 'asks the user for the name of a book to search' do
      allow(@reading_list).to receive(:make_query).and_return(@book_query)
      allow(@reading_list).to receive(:retreive_query_results).and_return(@books_stub)
      expect { @reading_list.run }.to output("Type the name of the book you want to search then hit enter:\n\n---------------\nSearch results:\n---------------\n1. 100 Flowers to Knit & Crochet\nAuthor: Lesley Stanfield\nPublisher: Macmillan\n-------------------------------\n").to_stdout
    end
  end

  describe '#save_to_reading_list' do
    it 'saves a given book to the reading list' do
      @reading_list.save_to_reading_list(@books_stub[0])
      expect(@reading_list.get_list).to eq([{ title: '100 Flowers to Knit & Crochet', author: 'Lesley Stanfield', publisher: 'Macmillan' }])
    end

    it 'can save more than one book to the reading list' do
      @reading_list.save_to_reading_list(@books_stub[0])
      @reading_list.save_to_reading_list(@books_stub_2[0])
      expect(@reading_list.get_list).to eq([{ title: '100 Flowers to Knit & Crochet', author: 'Lesley Stanfield', publisher: 'Macmillan' },
                                            { title: 'Interpretative Phenomenological Analysis', author: 'Jonathan A Smith,Paul Flowers,Michael Larkin', publisher: 'SAGE' }])
    end
  end
end
