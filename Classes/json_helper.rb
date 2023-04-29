require 'json'

module JsonHelper
  # Recieves an array of instances. Makes a hash with the key  equal to the class
  # name of the instance + s. And the value is an array of the instances.
  # passes the hash to json_the_hash to be jsoned.
  # so breaker will return a hash whose values are all jsoned instances.
  def breaker(items = [])
    # make arrays
    # puts items
    my_hash = {}

    items.each do |item|
      array_name = "#{item.class.to_s.downcase}s"
      array_name = array_name.to_sym

      my_hash[array_name] = [] if my_hash[array_name].nil?
      my_hash[array_name].push(item)
    end

    json_the_hash(my_hash)
  end

  # Recieves a hash whose values are arrayss of instances. Loops through
  # the arrays of instance and calles their custom to_json method.
  # returns the hash with the values being the jsoned instances.
  def json_the_hash(hash)
    jsoned = {}
    hash.each do |key, value|
      jsoned[key] = value.map(&:to_json_custom)
    end

    # puts jsoned.to_json
    # unhash_the_json(jsoned.to_json)
    jsoned
  end

  # Recieves a json string. Parses the json string into a hash.
  # Passes the hash to uniter to be unjsoned.
  def unhash_the_json(json_string)
    hash = JSON.parse(json_string)
    # puts hash
    uniter(hash)
  end

  # Recieves a hash whose values are arrays of jsoned instances.
  #  Loops through the arrays of jsoned instances and calles their from_json method.
  # returns an array of instances.
  def uniter(hash)
    items_array = []
    # puts hash.class
    hash.each do |key, value|
      # puts value.class
      value.each do |obj_data|
        new_obj = item_factory(key)
        new_obj.from_json(obj_data)
        items_array << new_obj
      end
    end

    items_array
  end

  # Recieves a name of a class. Removes the last s
  # Returns an instance of that particular class.
  def item_factory(item_type)
    class_name = item_type.delete('s')
    case class_name
    when 'book'
      Book.new
    when 'game'
      Game.new
    when 'music_album'
      MusicAlbum.new
    end
  end

  # When calleed will change the whole instance into a json string.
  # For classes with instances that have attributes/properties that are arrays.
  # May work with other instances but not tested.
  # call breaker above
  # returns a json string
  def to_json_custom(*_args)
    my_hash = {}

    instance_variables.each do |var|
      my_hash[var] = if instance_variable_get(var).is_a?(Array)
                       breaker(instance_variable_get(var))
                     else
                       instance_variable_get(var)
                     end
    end
    my_hash.to_json
  end

  # For remaking an instance from a json string.
  # Made For instance which have atributes that are arays.
  # May work with other instances but not tested.
  # calls uniter above
  # doesnt return. Just sets the instance variables.
  def from_json(json_string)
    hash = JSON.parse(json_string, create_additions: true)

    hash.each do |var, val|
      if val.is_a?(Hash)
        instance_variable_set var, uniter(val)
      else
        instance_variable_set var, val
      end
    end
  end
end
