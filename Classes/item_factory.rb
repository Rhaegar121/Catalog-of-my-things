require_relative 'genre'
require_relative 'label'
require_relative 'author'
require_relative 'book'
require_relative 'game'
require_relative 'music_album'

module ItemFactory
  # Recieves a name of a class. Removes the last s
  # Returns an instance of that particular class.
  def item_factory(item_type)
    class_name = item_type.delete('s')
    case class_name
    when 'genre'
      Genre.new
    when 'label'
      Label.new
    when 'author'
      Author.new
    when 'book'
      Book.new
    when 'game'
      Game.new
    when 'music'
      MusicAlbum.new
    end
  end
end
