require_relative 'author'
require_relative 'input_validator'

class AuthorController
  include InputValidator
  attr_accessor :authors

  def initialize
    @authors = []
  end

  def create_author
    puts 'Please enter the following (Author) info: '
    print 'First Name: '
    first_name = fetch_valid_name('First Name: ')
    print 'Last Name: '
    last_name = fetch_valid_name('Last Name: ')

    full_name = "#{first_name.capitalize} #{last_name.capitalize}"

    if new_author?(full_name)
      author = Author.new(first_name: first_name, last_name: last_name)
      @authors << author
      puts '+++ New Author created! +++'
      author
    else
      puts 'Author already exists!'
      existing_author = @authors.find {	|auth| auth.to_s == full_name }
      puts 'Returning existing author...'
      existing_author
    end
  end

  def new_author?(full_name)
    authors.each do |author|
      return false if author.to_s == full_name
    end
    true
  end

  def list_authors
    if authors.empty?
      puts 'Please create an author'
    else
      puts '<<Authors: >>'
      authors.each do |author|
        # puts "Name: #{author.first_name} #{author.last_name}"
        puts "Name: #{author}"
      end
    end
  end
end

# ac = AuthorController.new
# ac.create_author
# ac.list_authors

# ac.create_author
# ac.list_authors
