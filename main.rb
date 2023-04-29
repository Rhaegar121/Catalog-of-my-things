require './Classes/app'

def list_options
  "Welcome to my catalog of things
    1 - Add a book
    2 - Add a music album
    3 - Add a game
    4 - List of all books
    5 - List of all music albums
    6 - List of games
    7 - List of all labels
    8 - List of all generes
    9 - List of all authors
    10 - Exit"
end

def option(option, app)
  case option
  when 1
    app.add_book
  when 2
    app.add_music_album
  when 3
    app.add_game
  when 4
    app.list_books
  when 5
    app.list_music_albums
  when 6
    app.list_games
  when 7
    app.list_labels
  when 8
    app.list_genres
  when 9
    app.list_authors
  when 10
    app.save_data
    exit
  else
    puts 'Invalid option, please type correct number!'
  end
end

def main
  app = App.new
  app.load_data

  loop do
    puts list_options
    puts
    print 'Please select an option:'
    option = gets.chomp.to_i
    option(option, app)
  end
end

main
