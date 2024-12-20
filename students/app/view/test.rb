require 'fox16'
require_relative 'students_list_view'
include Fox
app = FXApp.new
file_adapter = Students_list_storage.new(JSON_strategy.new('../res/data/sudents_list.json'))
students_list = Student_list.new(file_adapter)
puts students_list.get_k_n_student_short_list(1, 10).get_data.count_of_rows
puts students_list.get_student_short_count
StudentListView.new(app, students_list)
app.create
app.run