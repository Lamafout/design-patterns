require 'fox16'
require_relative 'students_list_view'
include Fox
app = FXApp.new
file_adapter = Students_list_storage.new(JSON_strategy.new('../res/data/sudents_list.json'))
students_list = Student_list.new(file_adapter)
StudentListView.new(app, file_adapter)
app.create
app.run