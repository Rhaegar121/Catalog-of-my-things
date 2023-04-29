require 'securerandom'

class Author
  attr_reader :id
  attr_accessor :first_name, :last_name, :items

  def initialize(first_name: '', last_name: '')
    @first_name = first_name
    @last_name = last_name
    generate_id
    @items = []
  end

  def generate_id
    @id = SecureRandom.uuid.delete('-')[0, 8]
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end

  def add_item(item)
    if item.author == self
      nil
    elsif item.author.nil?
      item.author = self
      @items << item unless @items.include?(item)
    else
      raise 'Item already has an author'
    end
  end

  def hashify
    {
      'first_name' => @first_name,
      'last_name' => @last_name,
      'items' => @items.map do |item|
        hashed_item = item.hashify
        hashed_item['class'] = item.class.to_s
        hashed_item
      end
    }
  end
end
