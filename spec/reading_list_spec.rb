require ("reading_list")

describe ReadingList do
  before(:each) do
    @reading_list = ReadingList.new
  end

  describe "#run" do
    it "asks the user for the name of a book to search" do
      expect{@reading_list.run}.to output("Type the name of the book you want to search then hit enter\n").to_stdout
    end
  end
end