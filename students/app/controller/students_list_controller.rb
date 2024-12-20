class Students_list_controller 
  def initialize(view)
    self.view = view
    self.students_list = Students_list.new(Student_list_storage_adapter(JSON_strategy.new('../res/data/sudents_list.json'))) 
    self.data_list = Data_list_student_short.new([])
    self.data_list.add_observer(self.view)
  end

  def refresh_data
    self.students_list.get_k_n_student_short_list(self.view.current_page, self.view.items_per_page - 1)
    
  end
end