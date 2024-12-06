require_relative '../student_list_interface.rb'
require_relative 'student_list_storage.rb'
class Student_list_storage_adapter < Student_list_interface
  def initialize(storage_strategy)
    self.student_list = Student_list_storage.new(storage_strategy)
  end

  def read_list_of_students
    self.student_list.read_list_of_students
  end

  def write_list_of_students
    self.student_list.write_list_of_students
  end

  def get_by_id(id)
    self.student_list.get_by_id(id)
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    self.student_list.get_k_n_student_short_list(k, n)
  end

  def sort
    self.student_list.sort
  end

  def insert_student(student)
    self.student_list.insert_student(student)
  end

  def replace_by_id(student)
    self.student_list.replace_by_id(student)
  end

  def delete_by_id(id)
    self.student_list.delete_by_id(id)
  end
  
  def get_student_short_count
    self.student_list.get_student_short_count
  end
end