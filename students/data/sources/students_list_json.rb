require 'json'
require_relative '../../domain/entities/short_student_class.rb'
require_relative '../../domain/entities/student_class.rb'
require_relative 'student_list_source.rb'

class Student_list_JSON < Student_list_source

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