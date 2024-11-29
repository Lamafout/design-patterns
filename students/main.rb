require_relative 'domain/entities/short_student_class'
require_relative 'core/binary_tree/binary_tree.rb'
require_relative 'data/model/data_list_student_short.rb'
require_relative 'data/sources/json_strategy.rb'
require_relative 'data/sources/yaml_strategy.rb'
require_relative 'data/sources/student_list_context.rb'

amal = Student.new(surname: 'Blyagoz', name: 'Amal', second_name: 'Khazretovich', git: 'github.com/lamafout', email: 'lamafout@yandex.ru', telegram: '@lamafout', birthdate: Date.new(2004, 6, 14))
sergey = Student.new(surname: 'Lotarev', name: 'Sergey', second_name: 'Urievuch', phone: '88005553535', birthdate: Date.new(2004, 10, 26))
mark = Student.new(surname: 'Anikin', name: 'Mark', second_name: 'Andreevich', email: 'mark.markovnik@gmail.com', birthdate: Date.new(2002, 10, 12))
# puts amal
# puts sergey
# puts mark
# puts amal.get_info
short_amal = Short_student.from_string(id: amal.id, string: amal.get_info)
# puts short_amal

# tree = Binary_tree.new
# tree.add(amal)
# tree.add(sergey)
# tree.add(mark)

# tree.iterator.each do |node|
#   puts node.name 
# end

# data_table = Data_table.new([[]])
# data_list = Data_list_student_short.new([short_amal])
# data_list.select(0)
# result =  data_list.get_data.get_by_index(0, 1)
# puts result

# sljson = Student_list_JSON.new('res/data/sudents_list.json')

# sljson.insert_student(sergey)

# sljson.read_list_of_students.each do |student|
#   puts student.name
# end

# sljson.get_k_n_student_short_list(1, 2).each do |student|
#   puts student
# end

# sljson.sort.each do |element|
#   puts element
# end

sl = Student_list_context.new 
sl.strategy = YAML_strategy.new('res/data/students_list.yaml')
sl.insert_student(sergey)

temp = sl.get_k_n_student_short_list(1, 3)
temp.select(1)
puts temp.get_data.count_of_rows