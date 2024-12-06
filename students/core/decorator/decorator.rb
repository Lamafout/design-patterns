require_relative './filter'

class Decorator < Filter
  def initialize(filter)
    self.filter = filter
  end

  def apply(decorable)
    self.filter.apply(decorable)
  end

  private
  attr_accessor :filter
end