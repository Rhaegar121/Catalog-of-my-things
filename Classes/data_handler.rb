require 'json'

def load_authors
  if File.exist?('./data/authors.json')
    authors_data = read_file('./data/authors.json')
    authors_data.map do |author_data|
      author = Author.new(first_name: author_data['first_name'], last_name: author_data['last_name'])
      author_data['items']&.each do |item_data|
        item_class = item_data['class']
        item = create_item(item_class, item_data)
        author.add_item(item)
      end
      author
    end
  else
    []
  end
end

def create_item(item_class, item_data)
  case item_class
  when 'Game'
    Game.new(name: item_data['name'],
             multiplayer: item_data['multiplayer'],
             last_played_at: item_data['last_played_at'],
             publish_date: item_data['publish_date'])
  when 'MusicAlbum'
    MusicAlbum.new(name: item_data['name'], on_spotify: item_data['on_spotify'],
                   publish_date: item_data['publish_date'])
  when 'Book'
    Book.new(title: item_data['name'], item_init: { author: item_data['author'] })
  end
end

def load_games
  if File.exist?('./data/games.json')
    games_data = read_file('./data/games.json')
    games_data.map do |game_data|
      Game.new(name: game_data['name'],
               multiplayer: game_data['multiplayer'],
               last_played_at: game_data['last_played_at'],
               publish_date: game_data['publish_date'])
    end
  else
    []
  end
end
