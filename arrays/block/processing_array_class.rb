class Processing_array
  attr_accessor :array

  def initialize(array)
    self.array = array
  end

  def get_index_of_min
    array.index(array.min)
  end
  def count_of_elems_in_range(range)
    array.count { |x| range.include?(x) }
  end
end