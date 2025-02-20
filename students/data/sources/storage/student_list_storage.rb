require_relative '../../model/data_list_student_short.rb'
require_relative 'source_strategy.rb'

class Students_list_storage 
  attr_accessor :strategy
  def initialize(strategy)
    self.strategy = strategy
  end

  def strategy=(strategy)
    if strategy.is_a?(Source_strategy)
      @strategy = strategy
    else 
      raise TypeError, 'Wrong type of strategy'
    end
  end

  def read_list_of_students
    self.strategy.read_list_of_students
  end

  def write_list_of_students
    self.strategy.write_list_of_students
  end

  def get_by_id(id)
    result = self.strategy.read_list_of_students.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 10, data_list = nil, filter = nil)
    k = 1 if k < 1 
    student_list = self.read_list_of_students

      filtered_list = filter.nil? ? student_list : filter.apply(student_list)
      student_short_list = filtered_list[((k-1) * n)...(k*n)].map do |student|
        Short_student.from_student(student)
      end
      # создание экземпляра Data_list_student_short и выбор всех прочитаных студентов
      result_data_list = Data_list_student_short.new(student_short_list)
      student_short_list.each_with_index do |_, index|
        result_data_list.select(index)
      end

      result_data_list.observers = data_list.observers
      result_data_list
  end

  def sort # sort by surname and name
    students_list = self.read_list_of_students.sort_by do |student|
      student.initials
    end
  end

  def insert_student(student)
    students_list = self.strategy.read_list_of_students
    if (unique_student?(student))
      students_list.push(student)
    else
      raise ArgumentError, 'Student already exists'
    end

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
  
  def get_student_short_count(filter = nil)
    students_list = self.strategy.read_list_of_students
    filtered_list = filter.nil? ? students_list : filter.apply(student_list)

    filtered_list.count
  end

  private
  def unique_student?(student)
    unigue_git?(student.git) && unique_phone?(student.phone) && unique_email?(student.email) && unique_telegram?(student.telegram)
  end

  def unigue_git?(git)
    unique_attr?(:git, git)
  end

  def unique_phone?(phone)
    unique_attr?(:phone, phone)
  end

  def unique_email?(email)
    unique_attr?(:email, email)
  end

  def unique_telegram?(telegram)
    unique_attr?(:telegram, telegram)
  end

  def unique_attr?(symbol, value)
    tree = Binary_tree.new
    self.strategy.read_list_of_students.each do |student|
      student.unique_indicator = symbol
      tree.add(student)
    end

    tree.iterator.each do |student|
      if student.unique_indicator == value
        return false
      end
    end
    true
  end
end
