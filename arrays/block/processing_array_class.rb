class Processing_array
  attr_accessor :array

  def initialize(array)
    self.array = array
  end

  def get_index_of_min
    array.index(array.min)
  end

  def count_of_elems_in_range(range)
    array.count { |elem| range.include?(elem) }
  end

  def count_of_elems_between_mins
    array.rindex(array.min) - array.index(array.min) - 1
  end
end