require_relative '../model/data_list_student_short.rb'
class Student_list_source

  def initialize(path)
    self.path = path
  end

  def read_list_of_students # must been implemented in children classes
    raise NotImplementedError, 'Must be implemented in children classes'
  end

  def write_list_of_students(students_list) # must been implemented in children classes
    raise NotImplementedError, 'Must be implemented in children classes'
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
    students_list = read_list_of_students.sort_by do |student|
      student.initials
    end
  end

  def insert_student(student)
    students_list = read_list_of_students
    students_list.push(student)

    write_list_of_students(students_list)
  end

  def replace_by_id(student)
    student_list = read_list_of_students.map do |object|
      if object.id == student.id
        object = student
      end
    end
  write_list_of_students(student_list)
  end

  def delete_by_id(id)
    student_list = read_list_of_students.delete_if do |student|
      student.id == id
    end

    write_list_of_students(student_list)
  end
  
  def get_student_short_count
    students_list = read_list_of_students

    students_list.count
  end

  private
  attr_accessor :path
end