require './Classes/item'

class Game < Item
  attr_accessor :name, :multiplayer, :last_played_at

  def initialize(name:, last_played_at:, multiplayer:, author: nil, **args)
    super(**args)
    @name = name
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @author = author
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end

  def hashify
    {
      'name' => @name,
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at,
      'publish_date' => @publish_date
    }
  end

  private

  def can_be_archived?
    Date.parse(@last_played_at) < Date.today.prev_year(2) && super
  end
end
