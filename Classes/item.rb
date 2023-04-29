require 'securerandom'
require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :publish_date, :archived

  def initialize(publish_date: '', genre: '', label: '', source: '', author: '')
    @publish_date = publish_date
    generate_id
    @genre = genre
    @label = label
    @source = source
    @author = author
  end

  def generate_id
    @id = SecureRandom.uuid.delete('-')[0, 8]
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  private

  attr_reader :id

  def can_be_archived?
    last_decade = Date.today.prev_year(10)
    Date.parse(@publish_date) < last_decade
  end
end
