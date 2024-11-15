class Data_list
  def initialize(list)
    self.list = list
    self.selected_elems = []
    self.index = 0
  end

  def select(index)
    raise "Index out of range" if index < 0 || index >= list.length
    self.selected_indexes << index
  end

  def get_names
    raise NotImplementedError, "Must be implemented!"
  end

  def get_data
    result_data = []
    self.selected_indexes.each do |index|
      data = self.list[index]
      new_row = [self.index] + row_from_attrs(data)
      result_data << new_row 
      self.index++
    end
    result_data
  end
  
  private
  attr_accessor :list, :selected_elems, :index

  def row_from_attrs(data) # part of the code that must be implemented in children classes
    raise NotImplementedError, "Must be implemented!"
  end
end