class Data_table

  def initialize(data)
    self.data = data
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