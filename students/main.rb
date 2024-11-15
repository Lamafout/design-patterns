require_relative 'domain/entities/short_student_class'
require_relative 'domain/entities/student_class.rb'
require_relative 'core/binary_tree/binary_tree.rb'
require_relative 'data/model/data_list_student_short.rb'
require_relative 'data/sources/students_list_json.rb'

amal = Student.new('Blyagoz', 'Amal', 'Khazretovich', id: 123, git: 'github.com/lamafout', email: 'lamafout@yandex.ru', telegram: '@lamafout', birthdate: Date.new(2004, 6, 14))
# sergey = Student.new('Lotarev', 'Sergey', 'Urievuch', phone: '88005553535', birthdate: Date.new(2004, 10, 26))
# mark = Student.new('Anikin', 'Mark', 'Andreevich', email: 'mark.markovnik@gmail.com', birthdate: Date.new(2002, 10, 12))
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

sljson = Students_list_json.new('res/sudents_list.json')

sljson.insert_student(amal)

sljson.read_list_of_students.each do |student|
  puts student.name
end