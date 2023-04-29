require_relative 'label'
require_relative 'input_validator'
require_relative 'read_save_helper'

class LabelController
  include ReadSaveHelper
  include InputValidator
  attr_accessor :labels

  def initialize
    @labels = populate_from_file('labels') || []
  end

  def create_label
    puts 'Please enter the following (Label) info: '
    print 'Title: '
    title = gets.chomp.to_s
    print 'Color: '
    color = fetch_valid_name('Color: ')
    label = Label.new(title: title, color: color)
    @labels.push(label)
    puts 'New Label created!'
  end

  def list_labels
    if @labels.empty?
      puts 'Please create a label'
    else
      @labels.each do |label|
        puts "Title: #{label.title}, Color: #{label.color}"
      end
    end
  end
end
