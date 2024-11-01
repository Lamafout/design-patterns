class Array_processor
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def all?
    result = true
    array.each do |elem|
      result = false if !yield elem
    end
    result
  end

  def flat_map
    result = []
    array.each do |elem|
      if elem.is_a? Array
        elem.each do |sub_elem|
          sub_elem = yield elem
        end
        result.concat elem
      else 
        mapped_element = yield elem
        result << mapped_element
      end
    end
    result
  end

end