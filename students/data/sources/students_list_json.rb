require 'json'
require_relative '../../domain/entities/short_student_class.rb'
require_relative '../../domain/entities/student_class.rb'

class Student_list_JSON
  def initialize(path)
    self.path = path
  end

  def read_list_of_students
    file = File.open(self.path, 'r')
    
    list = JSON.parse(file)
    list.map do |object|
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

  def get_by_id(id)
    students_list = read_list_of_students

    self.students_list.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1 
    student_list = read_list_of_students

    if students_list[k * n]
      students_list[((k-1) * n)...(k*n)]
    else
      raise IndexError, 'Index out of range'
  end

  def sort # sort by surname and name
    students_list = read_list_of_students

    self.students_list.sort_by do |student|
      [student.surname, student.name]
    end

    write_list_of_students(students_list)
  end

  def insert_student(student)
    students_list = read_list_of_students

    self.students_list.push(student)

    write_list_of_students(students_list)
  end

  def replace_by_id(student)
    students_list = read_list_of_students

    self.students_list.map do |object|
      if object.id == student.id
        object = student
      end
    end

    write_list_of_students(students_list)
  end

  def delete_by_id(id)
    students_list = read_list_of_students

    self.students_list.delete_if do |student|
      student.id == id
    end

    write_list_of_students(students_list)
  end

  def get_student_short_count
    students_list = read_list_of_students

    self.students_list.count
  end

  private
  attr_accessor :path
end