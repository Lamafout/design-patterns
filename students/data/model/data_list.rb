require_relative 'data_table'

class Data_list
  def initialize(list)
    self.list = list
    self.selected_indexes = []
    self.index = 0
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
    result_data = []
    self.selected_indexes.each do |index|
      data = self.list[index]
      new_row = [self.index].concat(row_from_attrs(data))
      puts new_row
      result_data << new_row 
      self.index += 1
    end
    result_table = Data_table.new(result_data)
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
      observer.update(self.get_data)
    end
  end
  
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