class Source_strategy

  def read_list_of_students # must been implemented in children classes
    raise NotImplementedError, 'Must be implemented in children classes'
  end

  def write_list_of_students(students_list) # must been implemented in children classes
    raise NotImplementedError, 'Must be implemented in children classes'
  end

  private
  attr_accessor :path
end