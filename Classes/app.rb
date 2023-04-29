require_relative './music_album'
require_relative './genre'
require 'json'
require_relative './item'
require_relative './game'
require_relative './author'
require_relative './data_handler'
require_relative 'book_controller'
require_relative 'author_controller'
require_relative 'label_controller'
require_relative 'genre_controller'
require_relative 'input_validator'

class App
  include InputValidator
  attr_accessor :albums, :genres, :games, :authors, :books, :labels

  def initialize
    @albums = []
    @genres = []
    @authors = []
    @games = []
    @books = []
    @labels = []

    # @label_controller = LabelController.new
    # @author_controller = AuthorController.new
    # @genre_controller = GenreController.new

    # @book_controller = BookController.new
  end

  def list_books
    if @books.empty?
      puts '~~ No books found! ~~'
      puts 'Please create a book...(7)'
    else
      puts '<<< List of Books >>>'
      @books.each do |book|
        puts "Title: #{book['Title']}, Publisher: #{book['Publisher']}, Cover_state: #{book['Cover_state']}"
      end
    end
  end

  def list_labels
    if @labels.empty?
      puts 'Please create a label'
    else
      @labels.each do |label|
        puts "Title: #{label['Title']}, Color: #{label['Color']}"
      end
    end
  end

  def add_book
    puts 'Please enter the following (Book) info: '
    print 'Book Title: '
    title = gets.chomp.to_s
    print 'Publisher: '
    publisher = gets.chomp.to_s
    print 'Publish date-(YYYY-MM-DD):  '
    publish_date = fetch_valid_date('Publish date-(YYYY-MM-DD):  ')
    print 'Cover state: (g)ood, (b)ad, or (o)k : '
    cover_state = fetch_valid_cover_state('Cover state: (g)ood, (b)ad, or (o)k : ')
    puts 'Please enter the following (Label) info: '
    print 'Title: '
    title = gets.chomp.to_s
    print 'Color: '
    color = fetch_valid_name('Color: ')
    puts '+++ New Book created! +++'

    book = Book.new(title: title, publisher: publisher, cover_state: cover_state)
    label = Label.new(title: title, color: color)

    @books.push({ 'Title' => book.title, 'Publisher' => book.publisher, 'Cover_state' => book.cover_state })
    @labels.push({ 'Title' => label.title, 'Color' => label.color })
  end

  def add_music_album
    puts 'Album title: '
    name = gets.chomp.to_s
    puts 'Publish date: '
    date = gets.chomp.to_s
    puts 'Genre: '
    genre_name = gets.chomp.to_s
    puts 'Is on spotify? [Y/N]: '
    answer = gets.chomp
    on_spotify = true if %w[Y y].include?(answer)
    on_spotify = false if %w[N n].include?(answer)
    puts 'New Music Album created! '

    album = MusicAlbum.new(name: name, on_spotify: on_spotify, publish_date: date)
    genre = Genre.new(genre_name)
    genre.add_item(album)

    @albums.push({ 'Title' => album.name, 'Publish_date' => album.publish_date, 'Is on spotify?' => album.on_spotify,
                   'Genre' => genre.name })
    @genres.push({ 'Genre' => genre.name })
  end

  def list_music_albums
    if @albums.empty?
      puts 'Please a music album'
    else
      @albums.each do |album|
        puts "Title: #{album['Title']}, Publish_date: #{album['Publish_date']}, Is on spotify?: #{album['Is on spotify?']}"
      end
    end
  end

  def list_genres
    if @genres.empty?
      puts 'Please a music album'
    else
      @genres.each { |genre| puts "Genre: \"#{genre['Genre']}\"" }
    end
  end

  def list_games
    if @games.empty?
      puts 'No games in the library'
      puts
    else
      @games.each_with_index do |game, index|
        puts "#{index}) #{game['name']} - Mutliplayer: #{game['multiplayer']}\n" \
             "\tLast played at: #{game['last_played_at']}\n" \
             "\tPublish date: #{game['Publish_date']}"
        puts
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts 'No authors in the library'
      puts
    else
      @authors.each_with_index do |author, index|
        puts "#{index}) Name: #{author['First_name']} #{author['Last_name']}\n" \
        "Items: #{author['Items']}"
        puts
      end
    end
  end

  def add_game
    puts 'Enter the game name:'
    name = gets.chomp
    puts 'Last played at(YYYY-MM-DD):'
    last_played_at = gets.chomp
    multiplayer = multi_player?
    puts 'Publish date(YYYY-MM-DD):'
    publish_date = gets.chomp
    puts 'Author(first name):'
    first_name = gets.chomp
    puts 'Author(last name):'
    last_name = gets.chomp
    game = Game.new(name: name, last_played_at: last_played_at, publish_date: publish_date, multiplayer: multiplayer)
    author = Author.new(first_name: first_name, last_name: last_name)
    author.add_item(game)

    @games.push({ 'name' => game.name, 'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at, 'Publish_date' => game.publish_date })

    @authors.push({ 
      'First_name' => author.first_name,
      'Last_name' => author.last_name, 
      'Items' => author.items.map do |item|
        hashed_item = item.hashify
        hashed_item['class'] = item.class.to_s
        hashed_item
      end
    })
    puts 'Game added successfully'
  end

  def multi_player?
    loop do
      puts 'Multiplayer(T/F):'
      choice1 = gets.chomp.upcase
      if choice1 == 'T'
        return true
      elsif choice1 == 'F'
        return false
      else
        puts 'Invalid option, please type T or F'
      end
    end
  end

  def save_data
    FileUtils.mkdir_p('data')
    File.write('data/albums.json', JSON.pretty_generate(@albums))
    File.write('data/genre.json', JSON.pretty_generate(@genres))
    File.write('data/authors.json', JSON.pretty_generate(@authors))
    File.write('data/games.json', JSON.pretty_generate(@games))
    File.write('data/books.json', JSON.pretty_generate(@books))
    File.write('data/labels.json', JSON.pretty_generate(@labels))
  end

  def read_file(file)
    file_data = File.read(file)
    JSON.parse(file_data)
  end

  def load_data
    @albums = File.exist?('data/albums.json') ? read_file('data/albums.json') : []
    @genres = File.exist?('data/genre.json') ? read_file('data/genre.json') : []
    @games = File.exist?('data/games.json') ? read_file('data/games.json') : []
    @authors = File.exist?('data/authors.json') ? read_file('data/authors.json') : []
    @books = File.exist?('data/books.json') ? read_file('data/books.json') : []
    @labels = File.exist?('data/labels.json') ? read_file('data/labels.json') : []
  end
end
