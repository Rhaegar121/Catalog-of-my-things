require_relative 'item'

class Book < Item
  attr_accessor :title, :publisher, :cover_state

  def initialize(title: '', publisher: '', cover_state: '', item_init: {})
    @title = title
    @publisher = publisher
    @cover_state = cover_state
    super(**item_init)
  end

  private

  def can_be_archived?
    super() || @cover_state == 'bad'
  end
end
