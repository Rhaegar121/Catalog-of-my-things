require_relative './music_album'
require_relative './genre'
require 'json'
require_relative './item'
require_relative './game'
require_relative './author'
require_relative './data_handler'
require_relative 'book_controller'
# require_relative 'music_album_controller'
require_relative 'author_controller'
require_relative 'label_controller'
require_relative 'genre_controller'

class App
  attr_accessor :albums, :genres, :games, :authors

  def initialize
    @albums = []
    @genres = []
    @authors = []
    @games = []

    @label_controller = LabelController.new
    @author_controller = AuthorController.new
    @genre_controller = GenreController.new

    @book_controller = BookController.new
  end

  def list_books
    @book_controller.list_books
  end

  def add_book
    author = @author_controller.create_author
    genre = @genre_controller.create_genre
    label = @label_controller.create_label

    @book_controller.create_book(author: author, genre: genre, label: label)
  end

  def list_labels
    @label_controller.list_labels
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
        puts "#{index}) #{game.name} - Mutliplayer: #{game.multiplayer}\n" \
             "\tLast played at: #{game.last_played_at}\n" \
             "\tPublish date: #{game.publish_date}"
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
        puts "#{index}) Name: #{author.first_name} #{author.last_name}\n" \
             "Items: #{author.items.map(&:name).join(', ')}"
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
    game = Game.new(name: name, last_played_at: last_played_at, publish_date: publish_date,
                    multiplayer: multiplayer)
    @games << game
    author = resolve_author(first_name, last_name)
    unless author.nil?
      author.add_item(game)
      @authors << author unless @authors.include?(author)
    end
    puts 'Game added successfully'
  end

  def resolve_author(first_name, last_name)
    return nil if first_name.empty? || last_name.empty?

    author = @authors.find { |a| a.first_name == first_name && a.last_name == last_name }
    author || Author.new(first_name: first_name, last_name: last_name)
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

    @book_controller.save_to_file('books', @book_controller.books)
    @label_controller.save_to_file('labels', @label_controller.labels)

    File.write('data/albums.json', JSON.pretty_generate(@albums))
    File.write('data/genre.json', JSON.pretty_generate(@genres))
    @authors.concat(@author_controller.authors)
    File.write('data/authors.json', JSON.pretty_generate(@authors.map(&:hashify)))
    File.write('data/games.json', JSON.pretty_generate(@games.map(&:hashify)))
  end

  def read_file(file)
    file_data = File.read(file)
    JSON.parse(file_data)
  end

  def load_data
    @albums = File.exist?('data/albums.json') ? read_file('data/albums.json') : []
    @genres = File.exist?('data/genre.json') ? read_file('data/genre.json') : []
    @games = load_games
    @authors = load_authors
  end
end
