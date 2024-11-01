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

end