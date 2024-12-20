class Student_list_interface
  def get_by_id(id)
    raise NotImplementedError, "You must implement this method"
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    raise NotImplementedError, "You must implement this method"
  end

  def sort
    raise NotImplementedError, "You must implement this method"
  end

  def insert_student(student)
    raise NotImplementedError, "You must implement this method"
  end

  def replace_by_id(student)
    raise NotImplementedError, "You must implement this method"
  end

  def delete_by_id(id)
    raise NotImplementedError, "You must implement this method"
  end
  
  def get_student_short_count(filter)
    raise NotImplementedError, "You must implement this method"
  end
end