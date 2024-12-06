require_relative 'student_list_interface'
class Student_list < Student_list_interface
  def initialize(adapter)
    self.adapter = adapter
  end

  def read_list_of_students
    adapter.read_list_of_students
  end

  def write_list_of_students
    self.adapter.write_list_of_students
  end

  def get_by_id(id)
    self.adapter.get_by_id(id)
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    self.adapter.get_k_n_student_short_list(k, n)
  end

  def sort
    self.adapter.sort
  end

  def insert_student(student)
    self.adapter.insert_student(student)
  end

  def replace_by_id(student)
    self.adapter.replace_by_id(student)
  end

  def delete_by_id(id)
    self.adapter.delete_by_id(id)
  end
  
  def get_student_short_count
    self.adapter.get_student_short_count
  end

end