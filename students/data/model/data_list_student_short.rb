require_relative 'data_list.rb'

class Data_list_student_short < Data_list

  def get_names
    ['indx', 'initials', 'git', 'contact']
  end

  private
  def row_from_attrs(data)
    return [data.id, data.initials, data.git, data.contact]
  end

  def element_type
    Short_student
  end
end