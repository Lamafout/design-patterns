require_relative '../student_list_interface.rb'
require_relative 'student_list_storage'
class Student_list_storage_adapter < Student_list_interface
  attr_accessor :storage
  def initialize(strategy)
    self.storage = Students_list_storage.new(strategy)
  end

  def get_by_id(id)
    self.storage.get_by_id(id)
  end

  def get_k_n_student_short_list(k = 1, n = 20, data_list = nil, filter = nil)
    self.storage.get_k_n_student_short_list(k, n, data_list, filter)
  end

  def sort
    self.storage.sort
  end

  def insert_student(student)
    self.storage.insert_student(student)
  end

  def replace_by_id(student)
    self.storage.replace_by_id(student)
  end

  def delete_by_id(id)
    self.storage.delete_by_id(id)
  end
  
  def get_student_short_count(filter = nil)
    self.storage.get_student_short_count(filter)
  end
end