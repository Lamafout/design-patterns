require 'json'
require_relative '../../../domain/entities/short_student_class.rb'
require_relative '../../../domain/entities/student_class.rb'
require_relative 'source_strategy.rb'

class JSON_strategy < Source_strategy

  def initialize(path)
    self.path = path
  end

  def read_list_of_students
    file = File.read(self.path)
    raise 'File is empty' if file.strip.empty?
    JSON.parse(file, symbolize_names: true).map do |object|
      Student.new(**object)
    end
  end

  def write_list_of_students(list)
    data = list.map do |object|
      object.to_h
    end
    File.open(self.path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end
end