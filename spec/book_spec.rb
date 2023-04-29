require './Classes/book'

describe Book do
  before :all do
    @book = Book.new(title: 'Super Awesome Book', publisher: 'Penguin', cover_state: 'bad', publish_date: '2023-04-25')
  end

  describe '#initialize' do
    it 'takes two parameters and returns a Book object' do
      expect(@book).to be_an_instance_of Book
    end

    it 'should be an item' do
      expect(@book).to be_an(Item)
    end
  end

  it 'can create a book with a publisher ' do
    expect(@book.publisher).to eq('Penguin')
  end

  it 'can create a book with a cover state' do
    expect(@book.cover_state).to eq('bad')
  end

  describe '#can_be_archived?' do
    it 'returns true if the book cover is bad' do
      expect(@book.send(:can_be_archived?)).to eq(true)
    end
  end
end
