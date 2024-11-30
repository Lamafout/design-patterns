require_relative '../model/data_list_student_short.rb'
require_relative 'source_strategy.rb'

class Student_list_context
  attr_reader :strategy

  def initialize
    self.strategy = Source_strategy.new
  end

  def strategy=(strategy)
    if strategy.is_a?(Source_strategy)
      @strategy = strategy
    else 
      raise TypeError, 'Wrong type of strategy'
    end
  end

  def get_by_id(id)
    result = self.strategy.read_list_of_students.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1 
    student_list = self.strategy.read_list_of_students

    if student_list[k * n]
      student_short_list = student_list[((k-1) * n)...(k*n)].map do |student|
        Short_student.from_student(student)
      end
      Data_list_student_short.new(student_short_list)
    else
      raise IndexError, 'Index out of range'
    end
  end

  def sort # sort by surname and name
    students_list = self.strategy.read_list_of_students.sort_by do |student|
      student.initials
    end
  end

  def insert_student(student)
    students_list = self.strategy.read_list_of_students
    students_list.push(student)

    self.strategy.write_list_of_students(students_list)
  end

  def replace_by_id(student)
    student_list = self.strategy.read_list_of_students.map do |object|
      if object.id == student.id
        object = student
      end
    end
    self.strategy.write_list_of_students(student_list)
  end

  def delete_by_id(id)
    student_list = self.strategy.read_list_of_students.delete_if do |student|
      student.id == id
    end

    self.strategy.write_list_of_students(student_list)
  end
  
  def get_student_short_count
    students_list = self.strategy.read_list_of_students

    students_list.count
  end
end