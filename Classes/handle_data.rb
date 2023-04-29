require 'fileutils'

class HandleData
  def self.read(file_name)
    file_name = "data/#{file_name}.json"
    # if File.empty?(file_name)
    # []
    # else

    if File.exist?(file_name)
      data = File.read(file_name)
      JSON.parse(data)
    else
      File.write(file_name, '[]')
      []
    end
  rescue StandardError
    # puts "...#{file_name} file not found..."

    FileUtils.mkdir_p('data')

    File.write(file_name)
    []
  end

  def self.write(file_name, data_array)
    # make data directory if it doesn't exist

    # FileUtils.mkdir_p('data')

    FileUtils.mkdir_p('data')

    file_name = "data/#{file_name}.json"
    json_string = JSON.dump(data_array)
    File.write(file_name, json_string)
  rescue StandardError
    puts 'Unable to save to file'
  end
end
