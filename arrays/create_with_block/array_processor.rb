class Array_processor
  attr_reader :array

  def initialize(array)
    self.array = array
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

  def one?
    result = 0
    array.each do |elem|
      result += 1 if yield elem
    end
    if result == 1
      true
    else 
      false
    end
  end

  def inject(initial = 0) 
    result = initial
    array.each do |elem|
      result = yield result, elem
    end
     result
  end

  def min_by
    result = array[0]
    array.each do |elem|
      result = elem if yield(elem) < yield(result)
    end
    result
  end

  def find
    array.each do |elem|
      return elem if yield elem
    end
    nil
  end

  private
  attr_writer :array
end