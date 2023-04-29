require_relative 'handle_data'
require_relative 'item_factory'

module ReadSaveHelper
  include ItemFactory
  def populate_from_file(filename)
    data = HandleData.read(filename)
    data_array = []

    return [] if data.empty?

    data.each do |item_string|
      item = item_factory(filename)
      item.from_json(item_string)
      data_array.push(item)
    end

    data_array
  end

  def save_to_file(filename, data_array)
    prepared_data = data_array.map(&:to_json_custom)
    HandleData.write(filename, prepared_data)
  end
end
