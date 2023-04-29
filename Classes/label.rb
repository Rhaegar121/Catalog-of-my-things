require 'securerandom'
require_relative 'book'
require_relative 'item'

class Label
  attr_accessor :title, :color

  def initialize(title: '', color: '')
    @title = title
    @color = color
    @items = []
    generate_id
  end

  def add_item(item)
    if item.label == self
      puts '!! Item already has this label !!'

    elsif item.label.instance_of?(Label) && item.label != self
      puts '!! Item already has a different label !!'
    else
      item.label = self
      @items << item unless @items.include?(item)
      puts 'Item Added'
    end
  end

  # private
  attr_accessor :id, :items

  def generate_id
    @id = SecureRandom.uuid.delete('-')[0, 8]
  end
end
