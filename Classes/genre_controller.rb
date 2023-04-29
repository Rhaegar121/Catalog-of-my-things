# require_relative 'genre'
require_relative 'input_validator'
require_relative 'read_save_helper'

class GenreController
  include ReadSaveHelper
  attr_accessor :genres

  include InputValidator
  def initialize
    @genres = populate_from_file('genres') || []
  end

  def create_genre
    puts 'Please enter the following (Genre) info: '
    print 'Genre: '
    genre_name = fetch_valid_name('Genre: ')

    if new_genre?(genre_name)
      genre = Genre.new(name: genre_name)
      @genres << genre
      puts '+++ New Genre created! +++'
      genre
    else
      puts 'Genre already exists!'
      existing_genre = @genres.find {	|gen| gen.to_s == genre_name.downcase }
      puts 'Returning existing genre...'
      existing_genre
    end
  end

  def new_genre?(genre_name)
    @genres.each do |genre|
      return false if genre.to_s == genre_name
    end
    true
  end

  def list_genres
    if @genres.empty?
      puts 'Please create a genre'
    else
      puts '<<< List Of Genres >>>'
      @genres.each do |genre|
        puts "Genre: #{genre.name}"
      end
    end
  end
end

# gn = GenreController.new
# gn.create_genre

# gn.list_genres

# gn.save_to_file('genres',gn.genres)
