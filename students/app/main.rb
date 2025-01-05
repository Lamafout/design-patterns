require 'fox16'
require_relative 'view/students_list_view'

include Fox

app = FXApp.new

StudentListView.new(app)
app.create
app.run