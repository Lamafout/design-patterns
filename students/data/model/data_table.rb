require_relative 'data_table.rb'

class Data_table

  def initialize(data)
    self.data = data
  end

  def get_by_index(row_index, column_index)
    result = nil
    if row_index >= 0 && row_index < data.length && column_index >= 0 && column_index < data[row_index].length
      result = data[row_index][column_index]
      puts result
    else
      raise IndexError, "Index is out of range"
    end
    result
  end

  def count_of_rows
    self.data.length
  end

  def count_of_columns
    return self.data.first.length if !self.data.first.nil?
    0
  end

  private
  attr_reader :data

  def data=(data) # check if data is two-dimensional array
    if data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
      @data = data
    else
      raise TypeError, "Data must be a two-dimensional array"
    end
  end
end