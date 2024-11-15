class Data_list
  def initialize(list)
    self.list = list
  end

  def select(index)
    self.selected_elems = list[index]
  end

  def get_names
  end

  def get_data
  end

  private
  attr_accessor :list, :selected_elems
end