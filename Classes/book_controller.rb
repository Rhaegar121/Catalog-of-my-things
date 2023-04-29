require_relative 'book'
require_relative 'input_validator'
require_relative 'handle_data'
require_relative 'read_save_helper'

class BookController
  include InputValidator
  include ReadSaveHelper
  attr_accessor :books

  def initialize
    @books = populate_from_file('books') || []
  end

  def create_book(author: '', genre: '', label: '')
    puts 'Please enter the following (Book) info: '
    print 'Book Title: '
    title = gets.chomp.to_s
    print 'Publisher: '
    publisher = gets.chomp.to_s
    print 'Publish date-(YYYY-MM-DD):  '
    publish_date = fetch_valid_date('Publish date-(YYYY-MM-DD):  ')
    print 'Cover state: (g)ood, (b)ad, or (o)k : '
    cover_state = fetch_valid_cover_state('Cover state: (g)ood, (b)ad, or (o)k : ')

    book = Book.new(title: title, publisher: publisher, cover_state: cover_state,
                    item_init: { author: author, genre: genre, label: label, publish_date: publish_date })

    @books.push(book)
    puts '+++ New Book created! +++'
  end

  def list_books
    if @books.empty?
      puts '~~ No books found! ~~'
      puts 'Please create a book...(7)'
    else
      puts '<<< List of Books >>>'
      @books.each do |book|
        print "Title: #{book.title} "
        puts "Author: #{book.author}"
      end
    end
  end
end
