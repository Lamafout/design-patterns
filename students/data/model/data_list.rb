require_relative 'data_table'

class Data_list
  def initialize(list)
    self.list = list
    self.selected_indexes = []
    self.index = 0
    self.count = 0
    self.observers = []
  end

  def select(index)
    raise "Index out of range" if index < 0 || index >= list.length
    self.selected_indexes << index
  end

  def clear_selected
    self.selected_indexes = []
  end

  def get_names
    raise NotImplementedError, "Must be implemented!"
  end

  def get_data
    result_data = [get_names]
    self.list.each_with_index do |row,index|
      data = self.list[index]
      new_row = [self.index].concat(row_from_attrs(data))
      result_data << new_row 
      self.index += 1
    end
    Data_table.new(result_data)
  end

  def list=(list)
    if correct_type?(list)
      @list = list
    else
      raise ArgumentError, "Wrong list format"
    end
  end

  def add_observer(observer)
    self.observers << observer
  end

  def notify
    self.observers.each do |observer|
      observer.set_table_params(self.get_names, self.count)
      observer.set_table_data(self.get_data)
    end
  end

  attr_accessor :observers, :count
  
  private
  attr_accessor :selected_indexes, :index
  attr_reader :list

  def row_from_attrs(data) # part of the code that must be implemented in children classes
    raise NotImplementedError, "Must be implemented!"
  end

  def correct_type?(var)
    if var.is_a?(Array)
      var.all?{ |item| item.is_a?(element_type) }
    else
      false
    end
  end

  def element_type
    Object
  end
end