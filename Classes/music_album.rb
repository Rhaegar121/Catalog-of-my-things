require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :name

  def initialize(name:, on_spotify: false, **args)
    super(**args)
    @on_spotify = on_spotify
    @name = name
  end

  def add_genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end

  def can_be_archived?
    super && @on_spotify
  end
end
