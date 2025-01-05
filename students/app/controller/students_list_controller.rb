require_relative '../../data/sources/student_list'
require_relative '../../data/sources/storage/student_list_storage_adapter'
require_relative '../../data/sources/storage/json_strategy'

class Students_list_controller 
  def initialize(view)
    self.view = view
    self.students_list = Student_list.new(Student_list_storage_adapter.new(JSON_strategy.new('res/data/sudents_list.json'))) 
    self.data_list = Data_list_student_short.new([])
    self.data_list.add_observer(self.view)
  end

  def refresh_data
    # Передача дата листа в метод получения страницы нужна для передачи информации о подписчиках на обновления
    self.data_list = self.students_list.get_k_n_student_short_list(self.view.current_page, self.view.items_per_page, self.data_list)
    self.data_list.count = self.students_list.get_student_short_count
    puts "Рефреш на стороне контроллера выполнен, уведомление об изменении вьюхи..."
    self.data_list.notify
  end

  private
  attr_accessor :view, :students_list, :data_list
end